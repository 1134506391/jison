# Jison 使用简介
# 官方文档： http://zaa.ch/jison/


# Jison 语法结构


# 标记解释 tokenizing 
使用 Flex 这个过程也成为 词法分析 lexical analysis，



# 句法分析 parsing
使用 Bison 这个过程也被称为 语义分析 semantic analyse
描述句法分析的方式称为形式文法 formal grammar 遵循形式文法的语言称为形式语言 formal language
形式文法分为四种
1、无限制文法 unrestricted grammar
2、上下文相关文法 context-sensitive grammar
3、上下文无关文法 context-free grammar
4、正则文法 regular grammar

Jison与Bison一样 采用上下文无关文法 context-free grammar


Jison的语法文件既可以把词法分析 lexical analysis 和语义分析 semantic analyse 分成两个文件
也可以在一个文件中同时包含这两部分
使用一个文件时
使用 %lex 和 /lex 标记区分词法分析 lexical analysis 部分和语义分析 semantic analyse 部分
%lex 和 /lex 标记中的 lex 即为 lexical 的缩写。


从 %lex 到 /lex 是词法分析 lexical analysis
从 /lex 到结束是 句法分析 parsing


词法分析中使用 %% 分为两部分 前面是词法分析的定义 definitions 下面例子中没有， 后面是词法分析的规则 rules
rules形式如下
pattern action
其中 pattern 为该规则 rules 匹配的模式，基于正则表达式，并增加部分扩展功能
action 为匹配模式时执行的动作
本例中词法分析 lexical analysis 的前两条规则 rules 中的模式 [^\n\r]+ 和 [\n\r]+ 即为正则表达式
本例中词法分析 lexical analysis 的第三条规则 rules 中的 <<EOF>> 即为匹配文件末尾的模式
本例中三条规则 rules 中的动作 action 都是直接返回标记 token 的名称，
分别为 LINE、EOL、EOF。Jison中词法分析 lexical analysis 的动作 action 使用JavaScript语法



# Jison 语法中的语义分析 semantic analyse 部分：
语义分析也使用 %% 分为两部分
%%之前是声明 declarations 部分
%%之后是语法规则 grammar rules 部分
本例仅有语法规则 没有声明

语法规则 比词法分析中的规则要复杂些，形式为：
result	: components...
				;
其中 components 为语法规则的组件部分，result 为匹配语法规则的结果，
本例中第三条语法规则 grammar rules 即为这种形式。
l
    : LINE EOL
    ;
其中，LINE EOL表示该语法规则需要匹配两个组成部分 LINE 和 EOL，当匹配时可以得到结果 l ，或者说 LINE 和 EOL 组合成 l。
LINE 和 EOL 中间的空格用于分割 LINE 和 EOL，并不参与匹配，因此可以按需增加空格
语法规则 grammar rules 中也可以设置匹配时执行的动作 action，
动作 action 放在组成部分 component 之后，
本例中第三条语法规则 grammar rules 的动作 action 为 { $$ = $1 + $2; }

Jison中语法规则 grammar rules 的动作 action 使用JavaScript语法。
本例中 $1 变量的值为匹配 LINE 的值，
也就是词法分析 lexical analysis 中返回 LINE 的规则中模式 pattern 定义的 [^\n\r]+ 匹配的字符串。
本例中 $2 变量的值为匹配 EOL 的值，也就是词法分析 lexical analysis 中返回 EOL 的规则中模式 pattern 定义的 [\n\r]+ 匹配的字符串。
赋值给变量 $$ 就是 LINE 和 EOL 组合成 l 的值，本例中 $1 和 $2 字符串简单连接，在实际中可以按需处理，后面的文章中有更复杂的例子


# 包含多项规则 rule 的语法规则 grammar rules
语法规则 grammar rules 也可以是匹配多种情况得到相同的结果，多个规则之间使用管道符号 | 连接，形式为
result	: rule1-components...
        | rule2-components...
        ...
        ;
本例中第二条语法规则 grammar rules 即为这种形式。
ll
    : ll l
    | l
    ;
其中第一项规则 ll l 表示该语法规则 grammar rules 需要匹配两个部分 ll 和 l
第二项规则 l 表示该语法规则 grammar rules 需要匹配一个部分 l
其中 l 由前面讲解的第三条语法规则定义
从这条语法规则 grammar rules 可以看出，组成部分不仅可以是词法分析 lexical analysis 中的标记 token，也可以是语法规则 grammar rules 中定义的规则

# 递归规则 recursive rule
语法规则 grammar rules 中定义的规则时，不仅可以是其他语法规则的结果，例如第二项规则 l，
还可以是自身，例如第一项规则就是 ll 和 ·l，
这种规则中包含自身的语法规则 有一个专门的名称————递归规则 recursive rule
