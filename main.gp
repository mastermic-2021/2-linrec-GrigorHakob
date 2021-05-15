u27 = ffgen(('x^3-'x+1)*Mod(1,3),'u);
codf27(s) = [if(x==32,0,u27^(x-97))|x<-Vec(Vecsmall(s)),x==32||x>=97&&x<=122];
ascii2str(v)=Strchr(v);

\\ Fonction pour coder un message dans F27

codf27(s) = [if(x==32,0,u27^(x-97))|x<-Vec(Vecsmall(s)),x==32||x>=97&&x<=122];

\\ Fonction pour decoder un message dans F27

decodf27(s)={
	v= vector(#s);
	for(i=1,#s,
		for(k=0,25,if(s[i]==u27^k,v[i]=k+97,if(s[i]==0,v[i]=32)););
	);
  ascii2str(v);
}

\\ Fonction d'exponentiation de Matrice récursive

ExpoMat(M,n) = {
	if(n==0,return( matid(40)));
	if(n== 1,return (M));
	if(n%2==0,return (ExpoMat(M^2,n/2)), return (M*ExpoMat(M^2,(n-1)/2)));
}

\\ Décomposition en facteurs premiers de n.

Decomp(M,n)={
	f=factor(n);
	for(i=1,matsize(f)[1], M=ExpMat(M,f[i,1]^f[i,2]));
	M;
}

\\ On récupere le chiffré et le nombre d'itérations

text  = read("input.txt")[1];
text2 = read("input.txt")[2];
n     = read("input.txt")[3];
text  = codf27(text);
text2 = codf27(text2);

\\ Matrice de transition 
   
M = matrix(40,40,i,j,if(j==i+1,1,0));
M[40,1] = -u27;
M[40,2] = -1;

\\  Matrice inverse de M 

M=M^(-1);
  
\\ La Recurrence du polynome 

M     = Decomp(M,n);
text2 = (M*(text2~));

text2 = decodf27(text2);
print(text2);
