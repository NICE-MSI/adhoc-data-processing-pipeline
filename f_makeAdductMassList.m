function [ adductMasses ] = f_makeAdductMassList( adducts, databaseMasses, polarity)

% This function calculates theoretical masses for all adducts listed in
% "adducts", monoisotopic masses specified in "databaseMasses", and
% polarity specified in "polarity".
%
% Inputs:
% adducts - list of strings of the shape -H, Cl for example
% databaseMasses - array of monoisopic masses
% polarity - chars 'positive' or 'negative'
%
% Outputs:
% adductMasses - theoretical masses for all adducts listed in adducts

adductMasses = zeros(size(databaseMasses,1), length(adducts));
for i = 1:length(adducts)
    [isotopes] = f_stringToFormula(adducts{i}); % converting a chemical formula string into a structure suitable for the isotopicdist function
    adductIsotopes = isotopicdist(isotopes);
    [~, l] = max(adductIsotopes(:,2));
    adductMass = adductIsotopes(1,l);
    adductMasses(:,i) = databaseMasses + adductMass;
end

if strcmp(polarity, 'positive') % add or lose mass of electron
    adductMasses = adductMasses - 0.00054858;
elseif strcmp(polarity, 'negative')
    adductMasses = adductMasses + 0.00054858;
end

end

