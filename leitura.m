function [ax,ay,az] = leitura(file)
    f = fopen(file,'r');
    format = '%f %f %f';
    a = fscanf(f,format);
    fclose(f);
    ax = zeros(1,1);
    ay = zeros(1,1);
    az = zeros(1,1);
    for t=1:3:length(a)
        ax(length(ax)+1) = a(t);
        ay(length(ay)+1) = a(t+1);
        az(length(az)+1) = a(t+2);
    end   

end
