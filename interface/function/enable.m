function enable(app,on_off)
   % on_off: "on" or "off"
   app.CreateButton.Enable = on_off;
   app.UITable.Enable = on_off;
   app.setupButton.Enable = on_off;
   app.showinfoButton.Enable = on_off;
end