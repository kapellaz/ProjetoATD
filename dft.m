function  dft_coefs = dft(user, exp, fs,sensors)
    % Auxiliar Variables
    labels = importdata("RawData/labels.txt");
    n_activities = 0;
    dft_coefs = cell(12,1,3);
    Ns=[];
    % DFT calculation
    for i = 1:12
        %buscar cada atvidade
        lab = intersect(intersect(find(labels(:,1) ==exp), find(labels(:,2)==user)), find(labels(:,3)==i));
        [A,b] = size(lab);
        if(A*b>0)
            n_activities=n_activities+1;
            values = [];
            file = sprintf("RawData/acc_exp0%s_user0%s.txt",string(exp),string(user));
            data = importdata(file);
            for p=1:b
                values=[values data((labels(lab(p),4):labels(lab(p),5)),:)];
            end
            [Ns(i),m]= size(values);
            for j = 1:3
                dft = fftshift(fft(values(:,j)));
                dft_coefs{i,1,j} = {dft};
            end 
        end
    end

    % Plotting
    
    if nargin > 1
        sgtitle("DFT plots of " + "exp"+exp+" usr" + user  ,'Interpreter','none');
        frame_counter = 1;
        for i=1:n_activities 
            N = Ns(i);
            disp(N)
            % Resolution in frequency
            fo = fs/N;
            if mod(N,2) == 0
                n = -N/2: N/2 - 1;
            else
                n = -fix(N/2): fix(N/2);
            end
            % Linear Frequency Domain
            freq = n * fo;
            % True Plotting
            for j = 1:3
                subplot(3,n_activities,frame_counter + n_activities*(j-1));
                plot(freq,abs(cell2mat(dft_coefs{i,1,j})));
                if(frame_counter == 1)
                    ylabel(sensors(j));  
                end
            end
            frame_counter = frame_counter + 1;
        end
    end
end
