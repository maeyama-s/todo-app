# ActiveHash::Baseは、ActiveRecordと同様のメソッドが使用できるようになる。
class Priority < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '重要度が高く、緊急度も高い' },
    { id: 3, name: '重要度は低く、緊急度が高い' },
    { id: 4, name: '重要度が高く、緊急度は低い' },
    { id: 5, name: '重要度は低く、緊急度も低い' }
  ]
  end