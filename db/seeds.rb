jenny = User.create(username: "jlee4three", name: "Jenny Lee", password: "jenny")
mark = User.create(username: "markymarkandthefunkybunch", name: "Mark Miller", password: "mark")
navraj = User.create(username: "therajtree", name: "Navraj Nat", password: "navraj")
dian = User.create(username: "d-pain", name: "Dian Pan", password: "dian")

testq1 = jenny.questions.create(title: "Why is testing so hard", body: "Why is controller testing so difficult when it is testing something so simple?")
answer1 = testq1.answers.create(body: "Jenny its not that bad.  Its really useful because once your are done with a feature you will no if any future changes to the code broke your previous work.  Checkout this site for some help, http://everydayrails.com/", user_id: 2)
answer2 = testq1.answers.create(body: "Mark has no idea what he's talking about.  He's a testing NOOOOOOBBBB", user_id: 3)
response1 = answer2.responses.create(user_id: 4, body: "Yeah he even uses deprecated should methods! What a joke!")
testq1.tags.create(name: "rspec")
testq1.tags.create(name: "testing")
testq1.tags.create(name: "DBC")


