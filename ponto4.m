function exercicio34=ponto4(Fs)
    Fs=50;
    labels = importdata("RawData/labels.txt");
    dinamicas=intersect(find(labels(:,1) ==1), find(labels(:,3)==1));
    dinamicas = vertcat(dinamicas,intersect(find(labels(:,1) ==1), find(labels(:,3)==2)));
    dinamicas = vertcat(dinamicas,intersect(find(labels(:,1) ==1), find(labels(:,3)==3)));
    estaticas=intersect(find(labels(:,1) ==1), find(labels(:,3)==4));
    estaticas = vertcat(estaticas,intersect(find(labels(:,1) ==1), find(labels(:,3)==5)));
    estaticas = vertcat(estaticas,intersect(find(labels(:,1) ==1), find(labels(:,3)==6)));
    transicao=intersect(find(labels(:,1) ==1), find(labels(:,3)==7));
    transicao = vertcat(transicao,intersect(find(labels(:,1) ==1), find(labels(:,3)==8)));
    transicao = vertcat(transicao,intersect(find(labels(:,1) ==1), find(labels(:,3)==9)));
    transicao = vertcat(transicao,intersect(find(labels(:,1) ==1), find(labels(:,3)==10)));
    transicao = vertcat(transicao,intersect(find(labels(:,1) ==1), find(labels(:,3)==11)));
    transicao = vertcat(transicao,intersect(find(labels(:,1) ==1), find(labels(:,3)==12)));
    data = importdata("RawData/acc_exp01_user01.txt");

    xdynamic=[];
    ydynamic=[];
    zdynamic=[];
    xstatica=[];
    ystatica=[];
    zstatica=[];
    xtransi=[];
    ytransi=[];
    ztransi=[];

    for i=1:3
        if i==1
            arr = dinamicas;
        end
        if i==2
            arr = estaticas;
        end
        if i==3
            arr = transicao;
        end
        [A, b] = size(arr);
        
        for p=1:A
            for j=1:3
                if j==1
                    values=data((labels(arr(p),4):labels(arr(p),5)),1);
                end
                if j==2
                    values=data((labels(arr(p),4):labels(arr(p),5)),2);
                end
                if j==3
                    values=data((labels(arr(p),4):labels(arr(p),5)),3);
                end

                [N,m]= size(values);

                if mod(N,2) == 0
                     f = -Fs/2:Fs/N:Fs/2-Fs/N;
                else
                    f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
                end

                dft=fftshift(fft(values));
                abs_dft=abs(dft);
                in = find(f>0);
                nf=f(f>0); 
                n = abs_dft(in);
                maximo=max(abs_dft(in));
                [vp, lp] = findpeaks(abs_dft(in));
                %disp("exp"+l+"user"+i);
                freq=nf(lp(1));
                if j==1
                    if i==1
                        xdynamic = [xdynamic freq];
                    elseif i==2
                        xstatica = [xstatica freq];
                    elseif i==3
                        xtransi = [xtransi freq];
                    end
                end

                if j==2
                    if i==1
                        ydynamic = [ydynamic freq];
                    elseif i==2
                        ystatica = [ystatica freq];
                    elseif i==3
                        ytransi = [ytransi freq];
                    end
                end
                if j==3
                    if i==1
                        zdynamic = [zdynamic freq];
                    elseif i==2
                        zstatica = [zstatica freq];
                    elseif i==3
                        ztransi = [ztransi freq];
                    end
                end
            end
        end
    end

    xdynamic
    ydynamic
    zdynamic
    xstatica
    ystatica
    zstatica
    xtransi
    ytransi
    ztransi
    dyn = scatter3(xdynamic, ydynamic, zdynamic);
        hold on
    stat = scatter3(xstatica, ystatica, zstatica);
        hold on
    trans = scatter3(xtransi, ytransi, ztransi);
        hold on
    xlabel("x");
    ylabel("y");
    zlabel("z");
    legend([dyn, stat, trans], {"dinamicas", "estaticas", "transicao"})
end