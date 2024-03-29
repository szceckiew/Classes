function [U] = odwr_rek(A, row_index, column_index, matrix_size, Z)
global Z;
if row_index == 1   
   if column_index == 1
       Matrix_dop = create_dop_matrix(A, row_index, column_index);
       Z(row_index,column_index) = (-1).^(row_index+column_index) * det(Matrix_dop);
   else
       odwr_rek(A, row_index, column_index - 1, matrix_size, Z);
       Matrix_dop = create_dop_matrix(A, row_index, column_index);
       Z(row_index,column_index) = (-1).^(row_index+column_index) * det(Matrix_dop);
   end
else
   if column_index == 1
       Matrix_dop = create_dop_matrix(A, row_index, column_index);
       Z(row_index,column_index) = (-1).^(row_index+column_index) * det(Matrix_dop);
   else
       odwr_rek(A, row_index, column_index - 1, matrix_size, Z);
       Matrix_dop = create_dop_matrix(A, row_index, column_index);
       Z(row_index,column_index) = (-1).^(row_index+column_index) * det(Matrix_dop);
   end
   if column_index == matrix_size
        odwr_rek(A,row_index-1, column_index, matrix_size, Z);
   end
end
if row_index == matrix_size && column_index == matrix_size
   U = (1/(det(A))) * Z.',
end
end

