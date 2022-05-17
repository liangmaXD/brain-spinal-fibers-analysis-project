for i=1:length(TractFE)
    for j=1:length(TractFE{1,i})
        TractFE{1,i}(j,:)=[0.3,0.1,0.86];
%         if((Tracts{1,i}(j,3)<98.1&&Tracts{1,i}(j,3)>91.3))||((Tracts{1,i}(j,3)>63.9&&Tracts{1,i}(j,3)<66.5))||((Tracts{1,i}(j,3)>61&&Tracts{1,i}(j,3)<62.9))
%             TractFE{1,i}(j,:)=[0,1,0];
%         end
    end
end
for k=length(Tracts2):-1:1
    if(Tracts2{1,k}(1,1)<Tracts2{1,k}(end,1))
        Tracts2{1,k}=flipud(Tracts2{1,k});
    end
    for i=length(Tracts2{1,k}):-1:1
        if(isnan(Tracts2{1,k}(i,1))||Tracts2{1,k}(i,1)==0)
            Tracts2{1,k}(i,:)=[];
        end
    end
end 
for k=1:length(Tracts2)
   if(length(Tracts2{1,k})<38)
       Tracts2{1,k}=[];
   end
end
Tracts2(cellfun(@isempty,Tracts2))=[];
profiber=Tracts2(ceil(length(Tracts2)./2));

pairpoint1=[profiber{1,1}(1,:);profiber{1,1}(15,:)];
pairpoint2=[profiber{1,1}(1,:);profiber{1,1}(16,:)];
pairpoint3=[profiber{1,1}(1,:);profiber{1,1}(38,:)];
pairpoint4=[profiber{1,1}(1,:);profiber{1,1}(end,:)];

d1=pdist(pairpoint1);
d2=pdist(pairpoint2);
d3=pdist(pairpoint3);
d4=pdist(pairpoint4);


for k=1:length(Tracts)
    if(Tracts{1,k}(1,1)<Tracts{1,k}(end,1))
        Tracts{1,k}=flipud(Tracts{1,k});
    end
    for j=1:length(Tracts{1,k})
        if(pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])>=d1 && pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])<=d2)
            TractFE{1,k}(j,:)=[0,1,0];
        end
        if(pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])>=d3 && pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])<=d4)
            TractFE{1,k}(j,:)=[0,1,0];
        end
%         if(pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])>=d5 && pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])<=d6)
%             TractFE{1,k}(j,:)=[0,1,0];
%         end
%         if(pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])>=d7 && pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])<=d8)
%             TractFE{1,k}(j,:)=[0,1,0];
%         end
%         if(pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])>=d9 && pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])<=d10)
%             TractFE{1,k}(j,:)=[0,1,0];
%         end
%         if(pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])>=d11 && pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])<=12)
%             TractFE{1,k}(j,:)=[0,1,0];
%         end
%         if(pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])>=d13 && pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])<=d14)
%             TractFE{1,k}(j,:)=[0,1,0];
%         end
%         if(pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])>=d15 && pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])<=d16)
%             TractFE{1,k}(j,:)=[0,1,0];
%         end
%         if(pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])>=d17 && pdist([Tracts{1,k}(1,:) ; Tracts{1,k}(j,:)])<=d18)
%             TractFE{1,k}(j,:)=[0,1,0];
%         end
    end  
end
