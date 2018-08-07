function printEquations(coeff, X_list, Y_list)

[row, col] = size(coeff);
n = sum(logical(coeff), 1);

for i = 1:col
    ind = find(coeff(:, i));
    fprintf('%s = ', Y_list{i})
    for j = 1:(n(i)-1)
        fprintf('%.4f*%s + ', coeff(ind(j), i), X_list{ind(j)});
    end
    j = j + 1;
    fprintf('%.4f*%s\n', coeff(ind(j), i), X_list{ind(j)});
end

end