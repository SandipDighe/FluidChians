function field = structuredData(datafile, gridfile, X, Y, fieldStr)
%input datafile (.gfs) and gridfile (.dat) along with X Y and Z from mesh grid
%output field 

%% more about the gridfile: it can be saved with this 

%gridfile='cartgrid2.dat';
%disp('saving the 2d grid');
%[X,Y,Z] = meshgrid(x,y,z);
%loc=[X(:),Y(:),Z(:)];
%save(gridfile,'loc','-ASCII','-SINGLE');

% This command is used for getting field values as a 2D matrix. 
% USed for the 2D slices inside the 3D simulation. 

disp('interpolating and loading')    
tic, 
ll=evalc(['!gfs2oogl3D -p ' gridfile ' -c ' fieldStr ' < ' datafile ]); 
% comment the third column -> Z
lolo=textscan(ll,'%f %f %*f %f \n'); 
toc
try
    field=reshape(lolo{3},size(X)); 
catch
    disp('reshape failed while getting structured data.........')
    x=lolo{1}; y=lolo{2};
    clear ll lolo
    plot(X(:),Y(:),'ko',x,y,'r.')
    legend('Expected Points', 'Actual Points')
end
