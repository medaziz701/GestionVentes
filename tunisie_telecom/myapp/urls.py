from django.urls import path
from django.contrib.auth.views import LoginView 
from .views import objectif_form, upload_file, success, generate_results, dashboard ,home,data_page,view_objectives,delete_objectif, edit_objectif,delete_month_content
from .views import  logout_view,admin_registration, user_registration , error_page,login_view
from .views import view_users,delete_user,confirm_user,reject_user,waiting_for_confirmation








urlpatterns = [
     path('waiting_for_confirmation/', waiting_for_confirmation, name='waiting_for_confirmation'), 
    path('confirm_user/<int:user_id>/', confirm_user, name='confirm_user'),
    path('reject_user/<int:user_id>/', reject_user, name='reject_user'),
    path('delete_user/<int:user_id>/', delete_user, name='delete_user'),
     path('view_users/', view_users, name='view_users'),
    path('upload/', upload_file, name='upload_file'),
    path('success/', success, name='success'),
    path('objectif/', objectif_form, name='objectif_form'),
    path('dashboard/', dashboard, name='dashboard'), 
     path('login/', login_view, name='login'),
    path('', home, name='home'),
     path('data/', data_page, name='data_page'),
      path('view_objectives/', view_objectives, name='view_objectives'),
      path('delete_objectif/<int:objectif_id>/', delete_objectif, name='delete_objectif'),
      path('edit_objectif/<int:objectif_id>/', edit_objectif, name='edit_objectif'),
        path('login/user/', login_view, {'user_type': 'user'}, name='user_login'),
    path('login/admin/', login_view, {'user_type': 'admin'}, name='admin_login'),
    path('delete_month_content/<str:month>/', delete_month_content, name='delete_month_content'),     
    path('logout/', logout_view, name='logout'),
    path('admin-registration/', admin_registration, name='admin_registration'),
    path('user-registration/', user_registration, name='user_registration'),
    path('error_page/', error_page, name='error_page'),
path('login/', LoginView.as_view(), name='login'),



           
            



      
      
     
    
]
