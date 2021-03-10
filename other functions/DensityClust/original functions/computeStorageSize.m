function storageSize = computeStorageSize(byteSize)
%COMPUTESTORAGESIZE computes the storage size in a readable format
%
% e.g.: byteSize = 2 .^ ([0, 3, 10:10:100])
%        storageSize = computeStorageSize(byteSize)

    storageSize = cell(numel(byteSize), 2);

    for i = 1 : numel(byteSize)

        tmp = byteSize(i);
        if tmp < (2^3)
            storageSize{i, 1} = (tmp / (2^0));
            storageSize{i, 2} = 'Bit';
        elseif tmp < (2^10)
            storageSize{i, 1} = (tmp / (2^3));
            storageSize{i, 2} = 'Byte';
        elseif tmp < (2^20)
            storageSize{i, 1} = (tmp / (2^10));
            storageSize{i, 2} = 'KB';
        elseif tmp < (2^30)
            storageSize{i, 1} = (tmp / (2^20));
            storageSize{i, 2} = 'MB';
        elseif tmp < (2^40)
            storageSize{i, 1} = (tmp / (2^30));
            storageSize{i, 2} = 'GB';
        elseif tmp < (2^50)
            storageSize{i, 1} = (tmp / (2^40));
            storageSize{i, 2} = 'TB';
        elseif tmp < (2^60)
            storageSize{i, 1} = (tmp / (2^50));
            storageSize{i, 2} = 'PB';
        elseif  tmp < (2^70)
            storageSize{i, 1} = (tmp / (2^60));
            storageSize{i, 2} = 'EB';
        elseif tmp < (2^80)
            storageSize{i, 1} = (tmp / (2^70));
            storageSize{i, 2} = 'ZB';
        elseif tmp < (2^90)
            storageSize{i, 1} = (tmp / (2^80));
            storageSize{i, 2} = 'YB';
        elseif tmp < (2^100)
            storageSize{i, 1} = (tmp / (2^90));
            storageSize{i, 2} = 'DB';
        elseif tmp < Inf
            storageSize{i, 1} = (tmp / (2^100));
            storageSize{i, 2} = 'NB';
        else
            error('Unkowen Size!');
        end

    end
    
end