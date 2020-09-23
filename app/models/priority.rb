# ActiveHash::Baseは、ActiveRecordと同様のメソッドが使用できるようになる。
class Priority < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '5' },
    { id: 3, name: '4' },
    { id: 4, name: '3' },
    { id: 5, name: '2' },
    { id: 6, name: '1' }
  ]
  end