function check_M(app)
   % 檢查規則
   % 1. Lens 必須要一個凹一個凸包成 Cube
   app.CreateButton.Enable = on_off;
   app.UITable.Enable = on_off;
   app.setupButton.Enable = on_off;
   app.showinfoButton.Enable = on_off;
end