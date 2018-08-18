from django.conf.urls import url
from main import views
#
urlpatterns = [
    url(r"^$", views.Index.as_view(), name='index'),
#     url(r'^login/$', auth.LoginView.as_view(), name='login'),
#     url(r'^login_submit/$', auth.LoginView.as_view(), name='login'),
#     url(r'^logout/$', auth.LogoutView.as_view(), name='logout'),
#     url(r'^verify/', captcha.CheckCode),
#     url(r'^modify/$', auth.Modify.as_view()),
]
# # include template url here ?
#
# urlpatterns += [
#     url(r'^config/$', data.ConfigProcess.as_view()),
#     url(r'^data/$', data.ViewProcess.as_view(), name='data'),
#     url(r'^download/$', data.DownloadProcess.as_view()),
#     url(r'^localUpload/$', data.UploadProcess.as_view()),
#     url(r'^localUploadStatus/$', data.UploadStatus.as_view()),
#     url(r'^heart/$', data.HeartProcess.as_view(), name='data'),
#     url(r'^device/(?P<url>.*)$', data.ProxyProcess.as_view()),
#     url(r'^(?P<url>.*).html$', data.ProxyProcess.as_view()),
#     url(r'^upload$', data.FileUploadProxy.as_view()),
#     url(r'^query(?P<url>.*)/$', data.ProxyProcess.as_view()),
# ]
#
#
