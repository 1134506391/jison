
// const text = `aaa
// `;

// const text = `aaa
// bbb
// `;

const text = `aa
bb
cc
`;
export default text;

// 1. 第一行 aaa 其实是 aaa/n
// 1.1 p.ll 是拿到text的全部内容
// 1.2 p.ll -> ll.l -> l.LINE EOL
// 1.3 把 l的返回值，赋值给到ll.l
// 2. 第二行 bbb 其实是bbb/n
// 2.1 p