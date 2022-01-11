%lex

%% 
\<Role\>.{0,19}|"NARRATOR"         { return 'ROLE'; } // 角色名 ^[A-Z][A-Z0-9\u0020'\\.·•]{0,19}
\'((?!\n\r).)*\'                   { return 'WORDS'; } // 对话
\r\n|[\r\n]                        { return 'EOL'; } // 匹配换行
<<EOF>>               return 'EOF'

/lex

%start story

%%

story //故事
    :events EOF { //事件,全文结束
        console.log("events:", $1)
        const data = {
            events: $1
        }
        return data;
    };

events //事件
    : dialog{ //对话
      $$ = $1
    }  
    | events dialog
    {
      $$ = $1.concat($2)
    };

dialog //对话
    : role LineBreak words{ //角色 行结束 对话
        console.log("role:",$1)
        console.log("LineBreak:",$2)
        console.log("words:",$3)
        // $3.forEach(word => {
        //     console.log("word:",word)
        // })
        $$ =  $1.concat($3)
    } 
    // | dialog LineBreak words{
    //   $$ = $1.concat($3)
    // }
    ;

role //角色
    : ROLE { 
        if ($1 === 'NARRATOR') {
            $$ = 'Narrator'
        } else {
            // console.log("42",$1)
            // console.log("43",$1.replace(/\<Role\>/g,''))
            // console.log("44",$1.replace(/\<Role\>/g,'').replace(/\s*$/g, ''))
            $$ = $1.replace(/\<Role\>/g,'').replace(/\s*$/g, '')
        }
    };

words //对话
    : lineWords {  //第一行
        const res =[]
        console.log(`lineWords--1`,$1)
        console.log(`lineWords--1text`,$1.text)
        res.push($1)
        $$ = res
    }
    | words lineWords{ //递归行,拼接
        // console.log("第二行")
        console.log(`words`,$1)
        console.log(`lineWords--2`,$2)
        $$ = $1.concat($2)
    };

lineWords //一行
    :WORDS LineBreak { 
         $$ = $1.replace(/\'/g,'')
    };

// 换行结构
LineBreak
    : EOL{
    }
    | LineBreak  EOL{
    };