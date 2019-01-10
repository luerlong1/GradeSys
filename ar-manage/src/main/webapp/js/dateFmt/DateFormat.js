function tableTimeFormat(v){
    var date = new Date(v);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
    var Y = date.getFullYear();
    var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1);
    var  D = date.getDate();
    D=D<10?("0"+D):D;
    var  h = date.getHours();
    h=h<10?("0"+h):h;
    var m = date.getMinutes();
    m=m<10?("0"+m):m;
    var s = date.getSeconds();
    s=s<10?("0"+s):s;
    return Y+"-"+M+"-"+D+" "+h+":"+m+":"+s;

}