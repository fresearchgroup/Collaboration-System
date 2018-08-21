from django.shortcuts import render, redirect

# Create your views here.

def manage_reputation(request):
    if request.user.is_superuser:
        if request.method == 'POST':
            pass
        else:
            return render(request, 'manage_reputation.html')
    else:
        return redirect('home')