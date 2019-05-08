#!/bin/bash
set -e

: ${ETHERPAD_DB_TYPE:=mysql}
: ${ETHERPAD_DB_HOST:=mysql}
: ${ETHERPAD_DB_PORT:=3306}
: ${ETHERPAD_DB_USER:=root}
: ${ETHERPAD_DB_NAME:=etherpad}
: ${ETHERPAD_DB_CHARSET:=utf8mb4}
ETHERPAD_DB_NAME=$( echo $ETHERPAD_DB_NAME | sed 's/\./_/g' )

# ETHERPAD_DB_PASSWORD is mandatory in mysql container, so we're not offering
# any default. If we're linked to MySQL through legacy link, then we can try
# using the password from the env variable MYSQL_ENV_MYSQL_ROOT_PASSWORD
if [ "$ETHERPAD_DB_USER" = 'root' ]; then
	: ${ETHERPAD_DB_PASSWORD:=$MYSQL_ENV_MYSQL_ROOT_PASSWORD}
fi

if [ -n "$ETHERPAD_DB_PASSWORD_FILE" ]; then
	: ${ETHERPAD_DB_PASSWORD:=$(cat $ETHERPAD_DB_PASSWORD_FILE)}
fi

if [ -z "$ETHERPAD_DB_PASSWORD" ]; then
	echo >&2 'error: missing required ETHERPAD_DB_PASSWORD environment variable'
	echo >&2 '  Did you forget to -e ETHERPAD_DB_PASSWORD=... ?'
	echo >&2
	echo >&2 '  (Also of interest might be ETHERPAD_DB_PASSWORD_FILE, ETHERPAD_DB_USER and ETHERPAD_DB_NAME.)'
	exit 1
fi

: ${ETHERPAD_TITLE:=Etherpad}
: ${ETHERPAD_PORT:=9001}

# Check if database already exists
if [ "$ETHERPAD_DB_TYPE" == 'mysql' ]; then
	RESULT=`mysql -u${ETHERPAD_DB_USER} -p${ETHERPAD_DB_PASSWORD} --port=${ETHERPAD_DB_PORT} \
		-h${ETHERPAD_DB_HOST} --skip-column-names \
		-e "SHOW DATABASES LIKE '${ETHERPAD_DB_NAME}'"`

	if [ "$RESULT" != $ETHERPAD_DB_NAME ]; then
		# mysql database does not exist, create it
		echo "Creating database ${ETHERPAD_DB_NAME}"

		mysql -u${ETHERPAD_DB_USER} -p${ETHERPAD_DB_PASSWORD} -h${ETHERPAD_DB_HOST} --port=${ETHERPAD_DB_PORT} \
		      -e "create database ${ETHERPAD_DB_NAME}"
	fi
fi
if [ "$ETHERPAD_DB_TYPE" == 'postgres' ]; then
	export PGPASSWORD=${ETHERPAD_DB_PASSWORD}
	if psql -U ${ETHERPAD_DB_USER} -h ${ETHERPAD_DB_HOST} postgres -lqt | cut -d \| -f 1 | grep -qw ${ETHERPAD_DB_NAME}; then
		true
	else
		# postgresql database does not exist, create it
		echo "Creating database ${ETHERPAD_DB_NAME}"
		psql -U ${ETHERPAD_DB_USER} -h ${ETHERPAD_DB_HOST} postgres \
			-c "create database ${ETHERPAD_DB_NAME}"
	fi
fi

if [ ! -f APIKEY.txt ] && [ ! -z "${ETHERPAD_API_KEY}" ] ; then
    echo "Creating APIKEY.txt as ETHERPAD_API_KEY is defined";
    echo "${ETHERPAD_API_KEY}" > APIKEY.txt
fi

if [ ! -f settings.json ]; then

	cat <<- EOF > settings.json
	{
	  "title": "${ETHERPAD_TITLE}",
	  "ip": "0.0.0.0",
	  "port": "${ETHERPAD_PORT}",
	  "dbType" : "${ETHERPAD_DB_TYPE}",
	  "dbSettings" : {
			    "user"    : "${ETHERPAD_DB_USER}",
			    "host"    : "${ETHERPAD_DB_HOST}",
			    "port"    : "${ETHERPAD_DB_PORT}",
			    "password": "${ETHERPAD_DB_PASSWORD}",
			    "database": "${ETHERPAD_DB_NAME}",
			    "charset": "${ETHERPAD_DB_CHARSET}"
			  },
	EOF

	if [ -n "$ETHERPAD_ADMIN_PASSWORD" ]; then

		: ${ETHERPAD_ADMIN_USER:=admin}

		cat <<- EOF >> settings.json
		  "users": {
		    "${ETHERPAD_ADMIN_USER}": {
		      "password": "${ETHERPAD_ADMIN_PASSWORD}",
		      "is_admin": true
		    }
		  },
		EOF
	fi

	cat <<- EOF >> settings.json
	"showSettingsInAdminPage" : true,
	"skinName": "colibris",
	"defaultPadText" : "",
	"padOptions": {
    "noColors": false,
    "showControls": true,
    "showChat": true,
    "showLineNumbers": true,
    "useMonospaceFont": false,
    "userName": false,
    "userColor": false,
    "rtl": false,
    "alwaysShowChat": false,
    "chatAndUsers": false,
    "lang": "en-gb"
  },

  /*
   * Pad Shortcut Keys
   */
  "padShortcutEnabled" : {
    "altF9"     : true, /* focus on the File Menu and/or editbar */
    "altC"      : true, /* focus on the Chat window */
    "cmdShift2" : true, /* shows a gritter popup showing a line author */
    "delete"    : true,
    "return"    : true,
    "esc"       : true, /* in mozilla versions 14-19 avoid reconnecting pad */
    "cmdS"      : true, /* save a revision */
    "tab"       : true, /* indent */
    "cmdZ"      : true, /* undo/redo */
    "cmdY"      : true, /* redo */
    "cmdI"      : true, /* italic */
    "cmdB"      : true, /* bold */
    "cmdU"      : true, /* underline */
    "cmd5"      : true, /* strike through */
    "cmdShiftL" : true, /* unordered list */
    "cmdShiftN" : true, /* ordered list */
    "cmdShift1" : true, /* ordered list */
    "cmdShiftC" : true, /* clear authorship */
    "cmdH"      : true, /* backspace */
    "ctrlHome"  : true, /* scroll to top of pad */
    "pageUp"    : true,
    "pageDown"  : true
  },

  /*
   * Should we suppress errors from being visible in the default Pad Text?
   */
  "suppressErrorsInPadText" : false,

  /*
   * If this option is enabled, a user must have a session to access pads.
   * This effectively allows only group pads to be accessed.
   */
  "requireSession" : true,

  /*
   * Users may edit pads but not create new ones.
   *
   * Pad creation is only via the API.
   * This applies both to group pads and regular pads.
   */
  "editOnly" : true,

  /*
   * If set to true, those users who have a valid session will automatically be
   * granted access to password protected pads.
   */
  "sessionNoPassword" : false,

  /*
   * If true, all css & js will be minified before sending to the client.
   *
   * This will improve the loading performance massively, but makes it difficult
   * to debug the javascript/css
   */
  "minify" : true,

  /*
   * How long may clients use served javascript code (in seconds)?
   *
   * Not setting this may cause problems during deployment.
   * Set to 0 to disable caching.
   */
  "maxAge" : 21600, // 60 * 60 * 6 = 6 hours

  /*
   * Absolute path to the Abiword executable.
   *
   * Abiword is needed to get advanced import/export features of pads. Setting
   * it to null disables Abiword and will only allow plain text and HTML
   * import/exports.
   */
  "abiword" : null,

  /*
   * This is the absolute path to the soffice executable.
   *
   * LibreOffice can be used in lieu of Abiword to export pads.
   * Setting it to null disables LibreOffice exporting.
   */
  "soffice" : null,

  /*
   * Path to the Tidy executable.
   *
   * Tidy is used to improve the quality of exported pads.
   * Setting it to null disables Tidy.
   */
  "tidyHtml" : null,

  /*
   * Allow import of file types other than the supported ones:
   * txt, doc, docx, rtf, odt, html & htm
   */
  "allowUnknownFileEnds" : true,

  /*
   * This setting is used if you require authentication of all users.
   *
   * Note: "/admin" always requires authentication.
   */
  "requireAuthentication" : false,

  /*
   * Require authorization by a module, or a user with is_admin set, see below.
   */
  "requireAuthorization" : false,

  /*
   * When you use NGINX or another proxy/load-balancer set this to true.
   */
  "trustProxy" : false,

  /*
   * Privacy: disable IP logging
   */
  "disableIPlogging" : false,

  /*
   * Time (in seconds) to automatically reconnect pad when a "Force reconnect"
   * message is shown to user.
   *
   * Set to 0 to disable automatic reconnection.
   */
  "automaticReconnectionTimeout" : 0,

  /*
   * By default, when caret is moved out of viewport, it scrolls the minimum
   * height needed to make this line visible.
   */
  "scrollWhenFocusLineIsOutOfViewport": {

    /*
     * Percentage of viewport height to be additionally scrolled.
     *
     * E.g.: use "percentage.editionAboveViewport": 0.5, to place caret line in
     *       the middle of viewport, when user edits a line above of the
     *       viewport
     *
     * Set to 0 to disable extra scrolling
     */
    "percentage": {
      "editionAboveViewport": 0,
      "editionBelowViewport": 0
    },

    /*
     * Time (in milliseconds) used to animate the scroll transition.
     * Set to 0 to disable animation
     */
    "duration": 0,

    /*
     * Flag to control if it should scroll when user places the caret in the
     * last line of the viewport
     */
    "scrollWhenCaretIsInTheLastLineOfViewport": false,

    /*
     * Percentage of viewport height to be additionally scrolled when user
     * presses arrow up in the line of the top of the viewport.
     *
     * Set to 0 to let the scroll to be handled as default by Etherpad
     */
    "percentageToScrollWhenUserPressesArrowUp": 0
  },

  /*
   * Users for basic authentication.
   *
   * is_admin = true gives access to /admin.
   * If you do not uncomment this, /admin will not be available!
   *
   * WARNING: passwords should not be stored in plaintext in this file.
   *          If you want to mitigate this, please install ep_hash_auth and
   *          follow the section "secure your installation" in README.md
   */

  /*
  "users": {
    "admin": {
      // "password" can be replaced with "hash" if you install ep_hash_auth
      "password": "changeme1",
      "is_admin": true
    },
    "user": {
      // "password" can be replaced with "hash" if you install ep_hash_auth
      "password": "changeme1",
      "is_admin": false
    }
  },
  */

  /*
   * Restrict socket.io transport methods
   */
  "socketTransportProtocols" : ["xhr-polling", "jsonp-polling", "htmlfile"],

  /*
   * Allow Load Testing tools to hit the Etherpad Instance.
   *
   * WARNING: this will disable security on the instance.
   */
  "loadTest": false,

  /*
   * Disable indentation on new line when previous line ends with some special
   * chars (':', '[', '(', '{')
   */

  /*
  "indentationOnNewLine": false,
  */

  /*
   * Toolbar buttons configuration.
   *
   * Uncomment to customize.
   */

  /*
  "toolbar": {
    "left": [
      ["bold", "italic", "underline", "strikethrough"],
      ["orderedlist", "unorderedlist", "indent", "outdent"],
      ["undo", "redo"],
      ["clearauthorship"]
    ],
    "right": [
      ["importexport", "timeslider", "savedrevision"],
      ["settings", "embed"],
      ["showusers"]
    ],
    "timeslider": [
      ["timeslider_export", "timeslider_returnToPad"]
    ]
  },
  */

  /*
   * The log level we are using.
   *
   * Valid values: DEBUG, INFO, WARN, ERROR
   */
  "loglevel": "INFO",

  /*
   * Logging configuration. See log4js documentation for further information:
   * https://github.com/nomiddlename/log4js-node
   *
   * You can add as many appenders as you want here.
   */
  "logconfig" :
    { "appenders": [
        { "type": "console"
        //, "category": "access"// only logs pad access
        }

      /*
      , { "type": "file"
      , "filename": "your-log-file-here.log"
      , "maxLogSize": 1024
      , "backups": 3 // how many log files there're gonna be at max
      //, "category": "test" // only log a specific category
        }
      */

      /*
      , { "type": "logLevelFilter"
        , "level": "warn" // filters out all log messages that have a lower level than "error"
        , "appender":
          {  Use whatever appender you want here  }
        }
      */

      /*
      , { "type": "logLevelFilter"
        , "level": "error" // filters out all log messages that have a lower level than "error"
        , "appender":
          { "type": "smtp"
          , "subject": "An error occurred in your EPL instance!"
          , "recipients": "bar@blurdybloop.com, baz@blurdybloop.com"
          , "sendInterval": 300 // 60 * 5 = 5 minutes -- will buffer log messages; set to 0 to send a mail for every message
          , "transport": "SMTP", "SMTP": { // see https://github.com/andris9/Nodemailer#possible-transport-methods
              "host": "smtp.example.com", "port": 465,
              "secureConnection": true,
              "auth": {
                  "user": "foo@example.com",
                  "pass": "bar_foo"
              }
            }
          }
        }
      */

      ]
    }

	}
	EOF
fi

exec "$@"
