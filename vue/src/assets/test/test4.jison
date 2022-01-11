%lex

%%
[^\n\r]+    { return 'LINE'; }  //非换行和回车之外的任意字符
[\n\r]+     { return 'EOL'; }  //换行和回车
<<EOF>>     { return 'EOF'; }

/lex

%%

p
    : ll EOF{      
        console.log("结果res",$1)
        return $1.toUpperCase()
    };

// ll
//     : ll l{    
//         console.log("22",$1)
//         console.log("33",$2)
//         $$ = $1 + $2 
//     }
//     | l{ 
//         console.log("44",$1)
//         $$ = $1;
//     };

// l
//     : LINE EOL{     
//         console.log("55",$1)
//         console.log("66",$2)
//         $$ = $1 + $2; 
//     };

ll
    : ll LINE EOL{    
        console.log("11",$1)
        console.log("22",$2)
        var res =  $1.concat($2)
        console.log("res:",res)
        console.log("----")
        $$ = res
    }
    | LINE EOL{ 
        console.log("33",$1)
        console.log("44",$2)
        $$ = $1 + $2; 
    };