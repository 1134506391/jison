/* eslint-disable*/
const text = `[scene1]
NARRATOR
'快到午饭时间了....'
<Role>小红
'中午吃什么好呢'
<Role>小明
'附近新开一家肠粉店'
'我们去吃吧'
<Role>小红
'好的'
<Role>小红
<Dress-up> 吃肠粉穿什么衣服好呢
<Option>黑裙
{
<Role>小红
'黑色会不会太庄重'
<Role>小明
'不会，很好看'
}
<Option>JK
{
<Role>小明
'JK好看'
<Role>小红
'好的'
}
<Option>牛仔裤
{
<Role>小红
'这个最显身材'
'就是它了'
<Role>小明
'好吧'
}
[scene2]
NARRATOR
'他们来到了肠粉店'
<Role>小明
<Choice>你喜欢吃蛋肠还是肉肠
<Option>蛋肠
{
<Role>小红
'我最喜欢吃蛋肠'
NARRATOR
'鸡蛋涨价了，菜单上显示贵多一块钱'
<Role>小明
'哪我们吃肉肠吧'
<Role>小红
'我生气了'
}
<Option>肉肠
{
<Role>小红
'我想吃肉肠'
<Role>小明
'好的'
}
<Role>小明
<Choice>吃完了肠粉，我们去看电影还是回公司加班
<Option>看电影
{
<Role>小明
<Choice>你喜欢看反贪风景还是机器总动员
<Option>反贪风景
{
<Role>小明
'最近新上映的'
'追新吧'
<Role>小红
'哪我们看一下简介吧'
NARRATOR
'反贪风景:古天乐主演....'
<Role>小红
'就他了'
<Role>小明
'好的'
}
<Option>机器总动员
{
<Role>小红
'我喜欢动画电影'
<Role>小明
'好的'
}
[scene3]
NARRATOR
'小明和小红一起去了电影院看电影'
}
<Option>公司加班
{
<Role>小明   
<Choice>怎么回去呢
<Option>地铁
{
<Role>小明
'地铁省钱'
<Role>小红
'没有座位坐'
}
<Option>打车
{
<Role>小红
'好的'
<Role>小明
'好的'
}
[scene4]
NARRATOR
'小明和小红一起加到公司加班'
}
`;
export default text;