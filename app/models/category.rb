# ActiveHash::Baseは、ActiveRecordと同様のメソッドが使用できるようになる。
class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: 'プライベート' },
    { id: 2, name: '仕事' },
    { id: 3, name: 'その他' }
  ]
end
