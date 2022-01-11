%lex

%% 

\s+                   {/* skip whitespace */}
("happy")             return 'happy'
("joy")               return 'joy'
.                     return 'INVALID'
<<EOF>>               return 'EOF'

/lex

// %start root

%%

root 
    :e EOF {
        var res = []
        function functionTest(){
            for(let i =0;i<10;i++){
                res.push(i)
            }
          
        }
        functionTest()
        console.log("res",res)
        return $1.toUpperCase() + res.join('');
    };
//写法一
//  e 
//      : happy e joy {
//          return [$1,$2,$3].join(' ')
 //     }
 //     | happy joy -> [$1, $2].join(' ')
 //     ;

//写法二
e 
    : happy e joy ->  [$1,$2,$3].join(' ')
    | happy joy -> [$1, $2].join(' ')
    ;

init 
    : {
        window.res = []
        window.functionTest = function(){
            for(let i =0;i<10;i++){
                res.push(i)
            }
            return res;
        }

    };