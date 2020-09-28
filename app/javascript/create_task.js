// taskという関数を定義
function task(){
  // 「タスク作成」ボタンの情報を取得
  const submit = document.getElementById("submit");
  // 「タスク作成」ボタンを「click」した場合に実行される関数を定義
  submit.addEventListener("click", (e) => {
    // FormDataは、フォームに入力された値を取得できるオブジェクト。
    const formData = new FormData(document.getElementById("form"));
    // 非同期通信を実装するために必要なXMLHttpRequestのオブジェクトを生成
    const XHR = new XMLHttpRequest();
    // openは、XMLHttpRequestで定義されているメソッドで、リクエストを初期化。どのようなリクエストをするのかを指定するメソッド
    XHR.open("POST", "/tasks/create", true);
    // レスポンスの形式を定義
    XHR.responseType = "json";
    // タスク作成のフォームに入力された情報を送信
    XHR.send(formData);
    // onloadとは、XMLHttpRequestで定義されているプロパティで、レスポンスなどの受信が成功した場合に呼び出されるイベントハンドラー。
    XHR.onload = () => {
      // HTTPステータスコードが200以外の場合、ifはtrueとなり、アラートを表示する処理が行われる。
      if (XHR.status != 200) {
        // XHR.statusTextによって、エラーが生じたオブジェクトに含まれるエラーメッセージが表示される。
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        // return null;によってJavaScriptの処理から抜け出すことができる。これはエラーが出た場合に、以降に記述されている処理を行わないようにすることが目的。
        return null;
      }
      // レスポンスとして返却されたタスクのレコードデータを取得
      const item = XHR.response.task;
      // HTMLを描画する場所を指定する際に使用する「描画する親要素」のtask-listの要素を取得
      const list = document.getElementById("task-list");
      // formTextを取得する理由は、タイトルの入力フォームをリセットするため。この処理が終了した時に、入力フォームの文字は入力されたままになってしまうため、リセットする必要がある。
      const formText = document.getElementById("title");
      // 「タスクとして描画する部分のHTML」を定義。HTMLという変数を描画するような処理を行えば、ここで定義したHTMLが描画される。
      const HTML = `
        <div class="task" data-id=${item.id}>
          <div class="task-content">
            ${item.title}
          </div>
        </div>`;
      // listという要素に対して、insertAdjacentHTMLでHTMLを追加。第一引数にafterendを指定することで、要素listの直後に挿入。
      list.insertAdjacentHTML("afterend", HTML);
      // 「タスクの入力フォームに入力されたままの文字」はリセットされる。正確には、空の文字列に上書きされるような仕組み。
      formText.value = "";
    };
    // 画面をリロードすると新たにもう1つ同じ投稿がされてしまう。プログラム本来の処理を、止めるためにe.preventDefault();で処理を停止させる。
    e.preventDefault();
  });
}
// window（ページ）をload（読み込み）時に実行
window.addEventListener("load", task);