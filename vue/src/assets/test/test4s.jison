%lex

%%
[^\n\r]+    { return 'LINE'; }  //非换行和回车之外的任意字符
[\n\r]+     { return 'EOL'; }  //换行和回车
<<EOF>>     { return 'EOF'; }

/lex

%%

p
    : ll EOF{        //规则一,第一个ll
        console.log("结果res",$1)
        return $1.toUpperCase()
    };

ll //第二个ll
    : ll LINE EOL{    //规则二，第三个ll
        console.log("11",$1)
        console.log("22",$2)
        var res =  $1.concat($2)
        console.log("res:",res)
        console.log("----")
        $$ = res
    }
    | l { //规则三
        $$ = $1; 
    };
l 
    : LINE EOL{ //规则三
        console.log("33",$1)
        console.log("44",$2)
        $$ = $1 + $2; 
    };

// const text = `aa
// bb
// cc
// `

// 1. 整个text，就是p
// 1.1 规则一对应上，解释规则一中的ll
// 1.2 第二个ll，解析文本走到aa\n 发现有规则三符合匹配
// 1.3 此时第二个ll，就是aa/n,第二个ll原来是'',reduce累加aa/n ,变成aa/n

// 2. aa/n 与bb/n 符合规则二, ll:aa/n ,LINE EOL:bb/n,第二个ll,reduces累加，变成aa/nbb/n
// 3. aa/nbb/n 与cc/n 符合规则二, ll:aa/nbb/n, LINE EOL:cc/n,第二个ll,reduces累加，变成aa/nbb/ncc/n