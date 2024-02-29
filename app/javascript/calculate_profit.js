const calc_fee = (price) => {
  return Math.floor(price * 0.1);
};

function calculate() {
  const item_price = document.getElementById("item-price");
    
  // item_priceがnullでないことを確認（要素が存在する場合のみイベントリスナーを追加）
  if (item_price) {
    // inputイベントリスナーを追加
    item_price.addEventListener("input", function() {
      // 入力値を取得
      const price = item_price.value;
      
      // ここに利益計算等の処理を追加
      const fee = calc_fee(price);
      const fee_item = document.getElementById("add-tax-price");

      // デフォルトのロケールを使用してカンマ区切りの形式に変換
      const formattedFee = new Intl.NumberFormat().format(fee);
      fee_item.textContent = formattedFee;

      const profit = price - fee;
      const formattedProfit = new Intl.NumberFormat().format(profit);
      const profit_item = document.getElementById("profit");
      profit_item.textContent = formattedProfit;
    });
  }

};

window.addEventListener("turbo:load", calculate);
window.addEventListener("turbo:render", calculate);