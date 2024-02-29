clear
clc
C = Cube();
C.set_name("Hello");
GP = GradientPrism();
GP.set_name("hi");
M = MediumList;
M.add(C)
M.add(GP)
%% medium list as table
num = length(M.list);
name = cell(num,1);
type = cell(num,1);
for ii = 1 : num
    name{ii} = char(M.list(ii).name);
    type{ii} = char(M.list(ii).type);
end
%%
T = table(name,type)

%% UITable 給值
UITable = uitable();
UITable.ColumnName = {'Name'; 'Type'};
UITable.RowName = {};
UITable.Data = table2cell(T);    % 不接受 string (格式為 {char,char...}