
function [Dop] = create_dop_matrix(A, row_index, column_index)
Dop = A;
Dop(row_index,:) = [];
Dop(:,column_index) = [];
end
