function steps_per_minute=spm(Fs)
    activities=[1, 2, 3];
    labels = importdata("RawData/labels.txt");
    for i=1:4
        walk=intersect(find(labels(:,2)==i), find(labels(:,3)==1));
        walkup=intersect(find(labels(:,2)==i), find(labels(:,3)==2));
        walkdown=intersect(find(labels(:,2)==i), find(labels(:,3)==3));
        valores_walk=[];
        valores_walkup=[];
        valores_walkdown=[]; 
        for j=1:3
            for l=1:8
                if j==1
                    [A,b] = size(walk);
                    arr=walk;
                end
                if j==2
                    [A,b] = size(walkup);
                    arr=walkup;
                end
                if j==3
                    [A,b] = size(walkdown);
                    arr=walkdown;
                end
                if(A*b>0)
                    for p=1:b
                        file = sprintf("RawData/acc_exp0%s_user0%s.txt",string(l),string(i));
                        if(isfile(file))
                            data = importdata(file);
                            values=data((labels(arr(p),4):labels(arr(p),5)),3);
                            [N,m]= size(values);
                            if mod(N,2) == 0
                                 f = -Fs/2:Fs/N:Fs/2-Fs/N;
                            else
                                f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
                            end
                            valores=data((labels(arr(p),4):labels(arr(p),5)),3);
                            %valores=detrend(valores);
                            dft=fftshift(fft(valores));
                            abs_dft=abs(dft);
                            in = find(f>0);
                            nf=f(f>0); 
                            n = abs_dft(in);
                            maximo=max(abs_dft(in));
                            [vp, lp] = findpeaks(abs_dft(in),'MinPeakHeight',maximo*0.4);
                            %disp("exp"+l+"user"+i);
                            freq=nf(lp(1));
                            npassos=freq*60;
                            if j==1
                                valores_walk=[valores_walk npassos];
                            end
                            if j==2
                                valores_walkup=[valores_walkup npassos];
                            end
                            if j==3
                                valores_walkdown=[valores_walkdown npassos];
                        end
                    end
                end
            end
        end
    end
    display("utilizador " + i);
    mediawalk=mean(valores_walk)
    mediawalkup=mean(valores_walkup)
    mediawalkdown=mean(valores_walkdown)
    desviowalk=std(valores_walk)
    desviowalkup=std(valores_walkup)
    desviowalkdown=std(valores_walkdown)

end