function generate_matrices(A, V, fname_prefix)
if(size(A,2) ~= length(V))
    disp('Bullshit!');
    return;
end
for i = 1:size(A,1)
    fid = fopen([fname_prefix int2str(i-1) '.bin'],'w');
    fwrite(fid, A(i,:), 'int32', 0, 'b');
    fclose(fid);
end
fid = fopen([fname_prefix 'vector.bin'],'w');
fwrite(fid, V, 'int32', 0, 'b');
fclose(fid);