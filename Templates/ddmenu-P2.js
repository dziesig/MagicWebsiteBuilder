var menu=function(){
	var t=15,z=50,s=2,a;
	function dd(n){this.n=n; this.h=[]; this.c=[]}
	dd.prototype.init=function(p,c){
		a=c; var w=document.getElementById(p), s=w.getElementsByTagName('ul'), l=s.length, i=0;
		for(i;i<l;i++){
			var h=s[i].parentNode; this.h[i]=h; this.c[i]=s[i];
			h.onmouseover=new Function(this.n+'.st('+i+',true)');
			h.onmouseout=new Function(this.n+'.st('+i+')');
// The following code was commented out to make IE8 checkboxes to work 12/12/2009
//                  xxx = this.n+'.sx('+i+')';
//                  eval(xxx);
		}
//            yyy = this.n+'.sz('+l+')';
//            if(l>0)document.body.onload=new Function(yyy);
	}
	dd.prototype.sz=function(num){
        for(i=0;i<num;i++)
        {
          this.st(i,1);
        }
        for(i=0;i<num;i++)
        {
          this.st(i,0);
        }
      }
	dd.prototype.sx=function(x){
        var c=this.c[x];
        clearInterval(c.t);
        c.style.height= '0px';
        c.style.opacity=0;
      }
	dd.prototype.st=function(x,f){
		var c=this.c[x], h=this.h[x], p=h.getElementsByTagName('a')[0];
		clearInterval(c.t); c.style.overflow='hidden';
		if(f){
			p.className+=' '+a;
			if(!c.mh){c.style.display='block'; c.style.height=''; c.mh=c.offsetHeight; c.style.height=0}
			if(c.mh==c.offsetHeight){c.style.overflow='visible'}
			else{c.style.zIndex=z; z++; c.t=setInterval(function(){sl(c,1)},t)}
		}else{p.className=p.className.replace(a,''); c.t=setInterval(function(){sl(c,-1)},t)}
	}
	function sl(c,f){
		var h=c.offsetHeight;
		if((h<=0&&f!=1)||(h>=c.mh&&f==1)){
			if(f==1){c.style.filter=''; c.style.opacity=1; c.style.overflow='visible'}
			clearInterval(c.t); return
		}
		var d=(f==1)?Math.ceil((c.mh-h)/s):Math.ceil(h/s), o=h/c.mh;
		c.style.opacity=o; c.style.filter='alpha(opacity='+(o*100)+')';
		c.style.height=h+(d*f)+'px'
//		if(f==-1&&d==1)clearInterval(c.t) /* Stops strange IE6 continuous dropdown problem*/
	}
	return{dd:dd}
}();
