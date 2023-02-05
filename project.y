%{
	#include <stdio.h>
	#include <ctype.h>
	int yylex(void);
	void yyerror(const char *);
	int n,i,j,an,nd[10],dim[10][10],can,r,inter;
	int a[20],c[20],rednum,vn;
	char b[20],name;
	int size_of_datatype,sz;
	int make_variable();
%}

%token id

%%
/* Final reduction printing. Split LHS and RHS and initiate reduction. */
S : id '=' E ';' { printf("After reduction number %d\n",rednum++); printf("%c = t%d\n\n",$1,b[$3]-48); }
 ;
/* If a '+' is encountered, split it into two halves and reduce it again. */
/* If it is the last term, reduce it by taking it as T state. */
E : E '+' T { printf("After reduction number %d\n",rednum++);
 i=make_variable(); $$=i; c[i]=vn; b[i]=vn+48; vn++; printf("t%d =",c[i]); if(a[$1]!=-1){printf("t%d + ",c[$1]);}
 else { printf("%c + ",b[$1]); } if(a[$3]!=-1){printf("t%d\n",c[$3]);} else { printf("%c\n",b[$3]); } }
 | T { $$=$1; }
 ;
/* T can be either a normal variable. id takes care of variables and if it is an
array, it will move to state L. */
T : id { printf("After reduction number %d\n",rednum++); i=make_variable();
a[i]=-1; b[i]=$1; $$=i; }
 | L { printf("After reduction number %d\n",rednum++); i=make_variable(); $$=i;
c[i]=vn; b[i]=vn+48; vn++;
 printf("t%d = %c[t%d]\n",c[i],name,c[$1]); can++; }
 ;
/* The variable name of the array is received in the token id. */
/* The index of the array can be an expression. Hence, recursively calling E to
reduce the index. */
/* The second term is for multi dimensional arrays. */
L : id '[' E ']' { printf("After reduction number %d\n",rednum++);
 name=$1; r=0; i=make_variable(); $$=i; c[i]=vn; b[i]=vn+48;
vn++; printf("t%d = ",c[i]); if(a[$3]!=-1){printf("t%d",c[$3]);}
 else { printf("%c",b[$3]); }
 if(r+1!=nd[can]) { printf(" *%d",size_of_datatype*dim[can][nd[can]-1-r]); }
 else { printf(" * %d",size_of_datatype); } r++; printf("\n");
}
 | L '[' E ']' { printf("After reduction number %d\n",rednum++);
 //inter=make_variable();
inter=vn++; printf("t%d = ",inter); if(a[$3]!=-1){printf("t%d",c[$3]);} else { printf("%c",b[$3]); }
 if(r+1!=nd[can]) { printf(" *%d",size_of_datatype*dim[can][nd[can]-1-r]); } else { printf(" *%d",size_of_datatype); }
 r++; printf("\n");
i=make_variable(); $$=i; c[i]=vn; b[i]=vn+48; vn++;
printf("t%d = t%d + t%d\n",c[i],c[$1],inter);
 }
 ;
%%
int main()
{
 rednum=1; vn=1;
 printf("Enter size of data type : \n");
 scanf("%d",&size_of_datatype);
 printf("Enter no of arrays : \n");
 scanf("%d",&an);
 int y,l;
 for(y=0;y<an;y++)
 {
 printf("Enter no of dimension of %d array : \n",y+1);
 scanf("%d",&nd[y]);
 printf("Enter dimensions of %d array : \n",y+1);
 for(l=0;l<nd[y];l++)
 {
 scanf("%d",&dim[y][l]);
 }
 }
 //an=1; nd[0]=2; dim[0][0]=2; dim[0][1]=3;
 can=0;
 int x=0;
 for(x=0;x<20;x++) { a[i]=0; }
 n=1;
 printf("Enter Expression ending with Semicolon\n");
 getchar();
 yyparse();
 return 0;
}
int make_variable()
{
 return n++;
}
void yyerror(const char *str)
{
 printf("NITW Error occuring\n");
}
int yywrap()
{
 return 1;
}
