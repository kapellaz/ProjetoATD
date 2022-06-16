sensores = ["ACC-X","ACC-Y","ACC-Z"];

atividade = ["W","WU","WD","S","ST","L","STSit","SitTS","SitTL","LTSit","STL","LTS"];

labels = importdata("RawData/labels.txt"); % Importa a data das labels

Fs = 50; %Hz de acordo com o enunciado

conta_users=1;
k=1;

%%ex1 e 2
while k<9

    control = 0;
    file = sprintf("RawData/acc_exp0%s_user0%s.txt",string(k),string(conta_users));

    if isfile(file)
        info = importdata(file);
        this_labels = intersect(find(labels(:,1) ==k), find(labels(:,2)==conta_users));
        time = (0:size(info)-1)./Fs; %em segundos

        [lines,n_acc] = size(info);

        % Desenha 10 figuras independentes
        figure;
        sgtitle("Plot of " + "exp"+k+" usr" + conta_users ,'Interpreter','none');
        for i=1:n_acc %3 graficos por figura
            subplot(n_acc,1,i);
            plot(time./60, info(:,i), "k--"); %tempo em minutos
            xlabel("Time(min)", "fontSize",8, "FontWeight","bold");
            ylabel(sensores(i),"fontSize",8, "FontWeight","bold");
            hold on
            for j=1: numel(this_labels)
                plot(time(labels(this_labels(j),4):labels(this_labels(j),5))./60,info(labels(this_labels(j),4):labels(this_labels(j),5),i));
                if mod(j,2) ==1 %escreve em baixo
                    y=min(info(:,i));
                else %escreve em cima
                    y = max(info(:,i));
                end
                text(time(labels(this_labels(j),4))./60,y,atividade(labels(this_labels(j),3)),"VerticalAlignment","top","HorizontalAlignment","left");
            end
        end
        hold off

    else
        conta_users=conta_users+1;
        k=k-1;
    end
    k=k+1;
end
%% Ex3
%

sensores = ["ACC-X","ACC-Y","ACC-Z"];

atividade = ["W","WU","WD","S","ST","L","STSit","SitTS","SitTL","LTSit","STL","LTS"];

labels = importdata("RawData/labels.txt"); % Importa a data das labels

Fs = 50; %Hz de acordo com o enunciado

conta_users=1;
k=1;
while k<9
    control = 0;
    file = sprintf("RawData/acc_exp0%s_user0%s.txt",string(k),string(conta_users));

    if isfile(file)
        info = importdata(file);
        figure
        dft(conta_users,k , Fs, sensores);

    else
        conta_users=conta_users+1;
        k=k-1;
    end
    k=k+1;
end

%%

sensores = ["ACC-X","ACC-Y","ACC-Z"];

atividade = ["W","WU","WD","S","ST","L","STSit","SitTS","SitTL","LTSit","STL","LTS"];

labels = importdata("RawData/labels.txt"); % Importa a data das labels

Fs = 50; %Hz de acordo com o enunciado

conta_users=1;
k=1;

dft(6,11 , Fs, sensores);

%% calcula steps
spm(Fs);



%%
% 3.4
ponto4(Fs);

