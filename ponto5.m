function exercicio35=ponto5(Fs)
    Fs=50;
    labels = importdata("RawData/labels.txt");
    walk=intersect(intersect(find(labels(:,1) ==1), find(labels(:,2) ==1)),find(labels(:,3)==1));
    walkup = intersect(intersect(find(labels(:,1) ==1), find(labels(:,2) ==1)), find(labels(:,3)==2));
    walkdown = intersect(intersect(find(labels(:,1) ==1), find(labels(:,2) ==1)), find(labels(:,3)==3));
    sit=intersect(intersect(find(labels(:,1) ==1), find(labels(:,2) ==1)), find(labels(:,3)==4));
    stay = intersect(intersect(find(labels(:,1) ==1), find(labels(:,2) ==1)), find(labels(:,3)==5));
    lay = intersect(intersect(find(labels(:,1) ==1), find(labels(:,2) ==1)), find(labels(:,3)==6));
    standts=intersect(intersect(find(labels(:,1) ==1), find(labels(:,2) ==1)), find(labels(:,3)==7));
    sitts = intersect(intersect(find(labels(:,1) ==1), find(labels(:,2) ==1)), find(labels(:,3)==8));
    sittl = intersect(intersect(find(labels(:,1) ==1), find(labels(:,2) ==1)), find(labels(:,3)==9));
    ltsit = intersect(intersect(find(labels(:,1) ==1), find(labels(:,2) ==1)), find(labels(:,3)==10));
    standtl = intersect(intersect(find(labels(:,1) ==1), find(labels(:,2) ==1)), find(labels(:,3)==11));
    liets = intersect(intersect(find(labels(:,1) ==1), find(labels(:,2) ==1)), find(labels(:,3)==12));
    data = importdata("RawData/acc_exp01_user01.txt");

    x1=[];
    y1=[];
    z1=[];
    x2=[];
    y2=[];
    z2=[];    
    x3=[];
    y3=[];
    z3=[];    
    x4=[];
    y4=[];
    z4=[];    
    x5=[];
    y5=[];
    z5=[];    
    x6=[];
    y6=[];
    z6=[];    
    x7=[];
    y7=[];
    z7=[];    
    x8=[];
    y8=[];
    z8=[];    
    x9=[];
    y9=[];
    z9=[];    
    x10=[];
    y10=[];
    z10=[];    
    x11=[];
    y11=[];
    z11=[];    
    x12=[];
    y12=[];
    z12=[];

    for i=1:12
        if i==1
            arr = walk;
        elseif i==2
            arr = walkup;
        elseif i==3
            arr = walkdown;
        elseif i==4
            arr = sit;
        elseif i==5
            arr = stay;
        elseif i==6
            arr = lay;
        elseif i==7
            arr = standts;
        elseif i==8
            arr = sitts;
        elseif i==9
            arr = sittl;
        elseif i==10
            arr = ltsit;
        elseif i==11
            arr = standtl;
        elseif i==12
            arr = liets;
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
                        x1=[x1 freq];
                    elseif i==2
                        x2=[x2 freq];
                    elseif i==3
                        x3=[x3 freq];
                    elseif i==4
                        x4=[x4 freq];
                    elseif i==5
                        x5=[x5 freq];
                    elseif i==6
                        x6=[x6 freq];
                    elseif i==7
                        x7=[x7 freq];
                    elseif i==8
                        x8=[x8 freq];
                    elseif i==9
                        x9=[x9 freq];
                    elseif i==10
                        x10=[x10 freq];
                    elseif i==11
                        x11=[x11 freq];
                    elseif i==12
                        x12=[x12 freq];
                    end
                end

                if j==2
                    if i==1
                        y1=[y1 freq];
                    elseif i==2
                        y2=[y2 freq];
                    elseif i==3
                        y3=[y3 freq];
                    elseif i==4
                        y4=[y4 freq];
                    elseif i==5
                        y5=[y5 freq];
                    elseif i==6
                        y6=[y6 freq];
                    elseif i==7
                        y7=[y7 freq];
                    elseif i==8
                        y8=[y8 freq];
                    elseif i==9
                        y9=[y9 freq];
                    elseif i==10
                        y10=[y10 freq];
                    elseif i==11
                        y11=[y11 freq];
                    elseif i==12
                        y12=[y12 freq];
                    end
                end
                if j==3
                    if i==1
                        z1=[z1 freq];
                    elseif i==2
                        z2=[z2 freq];
                    elseif i==3
                        z3=[z3 freq];
                    elseif i==4
                        z4=[z4 freq];
                    elseif i==5
                        z5=[z5 freq];
                    elseif i==6
                        z6=[z6 freq];
                    elseif i==7
                        z7=[z7 freq];
                    elseif i==8
                        z8=[z8 freq];
                    elseif i==9
                        z9=[z9 freq];
                    elseif i==10
                        z10=[z10 freq];
                    elseif i==11
                        z11=[z11 freq];
                    elseif i==12
                        z12=[z12 freq];
                    end
                end
            end
        end
    end


    at1=scatter3(x1, y1, z1);
        hold on
    at2=scatter3(x2, y2, z2);
        hold on
    at3=scatter3(x3, y3, z3);
        hold on
    at4=scatter3(x4, y4, z4);
        hold on    
    at5=scatter3(x5, y5, z5);
        hold on
    at6=scatter3(x6, y6, z6);
        hold on    
    at7=scatter3(x7, y7, z7);
        hold on
    at8=scatter3(x8, y8, z8);
        hold on    
    at9=scatter3(x9, y9, z9);
        hold on
    at10=scatter3(x10, y10, z10);
        hold on    
    at11=scatter3(x11, y11, z11);
        hold on
    at12=scatter3(x12, y12, z12);
        hold on    

    xlabel("x");
    ylabel("y");
    zlabel("z");
    legend([at1,at2,at3,at4,at5,at6,at7,at8,at9,at10,at11,at12], {"WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING","SITTING", "LAYING", "STAND_TO_SIT", "SIT_TO_STAND", "SIT_TO_LIE", "LIE_TO_SIT", "STAND_TO_LIE", "LIE_TO_STAND"})
end