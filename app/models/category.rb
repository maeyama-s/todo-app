# ActiveHash::Baseは、ActiveRecordと同様のメソッドが使用できるようになる。
class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'プライベート' },
    { id: 3, name: '仕事' },
    { id: 4, name: 'その他' }
  ]
end
