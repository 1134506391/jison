/* eslint-disable*/
const text = `[Bedroom 26]
NARRATOR
'在一个天气晴朗周末的早上'
'xiaoming突然想起xiaohong同学,决定约她出来...'
<Role>xiaoming
'附近新开了一家火锅店，我们一起去吃吧'
<Role>xiaohong
'好的'
<Dress-up> 穿什么衣服好呢
<Option>黑裙
{
<Role>xiaohong
'黑色会不会太庄重'
<Role>xiaoming
'不会，很好看'
}
<Option>JK
{
<Role>xiaoming
'JK好看'
<Role>xiaohong
'好的'
}
<Option>牛仔裤
{
<Role>xiaohong
'这个最显身材'
'就是它了'
<Role>xiaoming
'好吧'
}
[Dining room 5]
<Role>xiaohong
'吃什么好呢'
<Role>xiaoming
'我们吃火锅吧'
<Role>xiaohong
'好的'
[scene2]
NARRATOR
'他们来到了肠粉店'
<Role>xiaoming
<Choice>你喜欢吃蛋肠还是肉肠
<Option>蛋肠
{
<Role>xiaohong
'我最喜欢吃蛋肠'
NARRATOR
'鸡蛋涨价了，菜单上显示贵多一块钱'
<Role>xiaoming
'哪我们吃肉肠吧'
<Role>xiaohong
'我生气了'
}
<Option>肉肠
{
<Role>xiaohong
'我想吃肉肠'
<Role>xiaoming
'好的'
}
<Role>xiaoming
<Choice>吃完了肠粉，我们去看电影还是回公司加班
<Option>看电影
{
<Role>xiaoming
<Choice>你喜欢看反贪风景还是机器总动员
<Option>反贪风景
{
<Role>xiaoming
'最近新上映的'
'追新吧'
<Role>xiaohong
'哪我们看一下简介吧'
NARRATOR
'反贪风景:古天乐主演....'
<Role>xiaohong
'就他了'
<Role>xiaoming
'好的'
}
<Option>机器总动员
{
<Role>xiaohong
'我喜欢动画电影'
<Role>xiaoming
'好的'
}
[scene3]
NARRATOR
'小明和小红一起去了电影院看电影'
}
<Option>公司加班
{
<Role>xiaoming   
<Choice>怎么回去呢
<Option>地铁
{
<Role>xiaoming
'地铁省钱'
<Role>xiaohong
'没有座位坐'
}
<Option>打车
{
<Role>xiaohong
'好的'
<Role>xiaoming
'好的'
}
[scene4]
NARRATOR
'小明和小红一起加到公司加班'
}
`;
export default text;