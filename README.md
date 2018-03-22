
                                    COLLABORATION SYSTEM

        Requiremnets -

                Django - 1.11.7 LTS
                python - 3.6
                Django Rest API
                Mysql

        Django pakages installed - 

                Django Rest Framework
                Widget Tweaks
                Django Reversion
                Reversion Compare
                MPTT
                Haystack
                Django Machina
                Django-cors-headers
                Django-role-permission
                Django_comments_xtd
                Django_comments


Steps for implementing Django with Mysql assuming you have already install Mysql server-

1. First thing we will need to do is install Python 3 database connector. Run the following command

    ```
    sudo apt-get install python3-dev

    ```

    ```
    sudo apt-get install python3-dev libmysqlclient-dev

    ```
    ```
    sudo pip3 install mysqlclient

    ```


2. Open the Mysql 'my.cnf' file and add the following -

  Open the file -

    ```
    sudo nano /etc/mysql/my.cnf

    ```
  Add to file -

      ```
      [client]
      database = db_name
      user = db_user
      password = db_password
      default-character-set = utf8
      
      ```
3. Finally run the following commands -

   ```
   sudo systemctl daemon-reload
   sudo systemctl restart mysql
   ```



 For Comments Module Add the following lines -
    ```  
    SITE_ID=1
    COMMENTS_APP='django_comments_xtd'
    COMMENTS_XTD_MAX_THREAD_LEVEL = 1 
    COMMENTS_XTD_LIST_ORDER = ('-thread_id', 'order') 
    COMMENTS_XTD_APP_MODEL_OPTIONS = {'allow_feedback': True, 'allow_flagging': True}
    ```
 Add the followin in view_article.html to show comments -
  ```
  <div class="comment">
    <h4 class="text-center">Your comment</h4>
      <div class="well">
        {% render_comment_form for article %}
      </div>
  </div>
  {% if comment_count %}
  <hr/>
    <ul class="media-list">
      {% render_xtdcomment_tree for article allow_flagging allow_feedback show_feedback %}
    </ul>
  {% endif %}
  ```

Apache Solr 6.5.0
Download link: http://archive.apache.org/dist/lucene/solr/6.5.0/solr-6.5.0.tgz



Installation Steps after database is configured- 

      - python3 manage.py loaddata workflow
      - python3 manage.py loaddata roles
      - python3 manage.py loaddata faq



Note:

After installing django -reversion compare module, copy the patch file from 'temp' folder of the project to virtualenv site- pakages.

 sudo cp Collaboration-System/temp/patch_for_reversion_compare.py  env/lib/python3.5/site-packages/reversion_compare

 cd env/lib/python3.5/site-packages/reversion_compare

 sudo mv patch_for_reversion_compare.py views.py


 Note:

 After migrations are done and all the tables are created, changes the body column in Articles tables to make it multilingual , will take symbols, unicode character etc.

 do --

 mysql -u root -p  (and select the database that is created and run the following sql query)
 
 ALTER TABLE BasicArticle_articles MODIFY COLUMN body text CHARACTER SET utf8 COLLATE utf8_general_ci NULL;

