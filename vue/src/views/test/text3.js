/* eslint-disable*/
const text = `[INT. EMMAS LIVING ROOM NIGHT]
NARRATOR
'After an amazing afternoon together, you’ve asked Reid to stay the night.'
<Role>REID
'You want me to stay the night?'
<Role>EMMA
'Yes. I want you to stay.'
'I mean if you want to.'
<Role>REID
'I definitely want to.'
<Role>EMMA
'Then follow me.'
[INT. EMMA BEDROOM NIGHT]
NARRATOR
'After giving Reid a toothbrush from the bathroom cabinet, you head to your room to change.'
<Role>EMMA
<Dress-up> What should I wear?
<Option>Black lace lingerie.
{
<Role>EMMA
'This is perfect.'
}
<Option>Lavender teddy.
{
<Role>EMMA
'This is beautiful.'
}
<Option>An oversized shirt and flannel pajamas.
{
<Role>EMMA
'Hmm, not very sexy.'
'But I guess this will do.'
}
<Role>EMMA
<Choice>…
<Option>Tell Reid you want him.
{
<Role>EMMA
'I want you.'
NARRATOR
'Reid captures your lips in a lustful kiss.'
'He stands up and watches you intently.'
}
<Role>EMMA
<Branch>close1
<Option>(11Black lace lingerie)
{
<Role>REID
'EMMA…'
'You look–wow.'
NARRATOR
'Your giggle is cut short as you watch Reid’s expression darken.'
<Role>EMMA
'Do you like it?'
<Role>REID
'Absolutely.'
}
<Option>(22Black lace lingerie)
{
<Role>REID
'EMMA…'
'You look–wow.'
NARRATOR
'Your giggle is cut short as you watch Reid’s expression darken.'
<Role>EMMA
'Do you like it?'
<Role>REID
'Absolutely.'
}
<Branch>close4
<Option>(Black lace lingerie)
{
<Role>REID
'EMMA…'
'You look–wow.'
NARRATOR
'Your giggle is cut short as you watch Reid’s expression darken.'
<Role>EMMA
'Do you like it?'
<Role>REID
'Absolutely.'
}
<Option> (Lavender teddy)
{
<Role>REID
'I think this may be my new favorite color.'
<Role>EMMA
'Is that so?'
<Role>REID
'You look incredible, EMMA.'
<Role>EMMA
'Thank you.'
}
`;
export default text;