function testgitter
[pde_fig,ax]=pdeinit;
pdetool('appl_cb',1);
set(ax,'DataAspectRatio',[1 1 1]);
set(ax,'PlotBoxAspectRatio',[3 2 1]);
set(ax,'XLim',[-0.2 2.2]);
set(ax,'YLim',[-0.2 1.2]);
set(ax,'XTickMode','auto');
set(ax,'YTickMode','auto');

dy =@(x,r) sqrt(4*r^2-x^2);
% Geometry description:
rl=0; rr=2; ru=0; ro=1;
pderect([rl rr ru ro],'Kasten');
% Anzahl Startpunkte
anz=6;
r=0.04;
xstart=2*rand([anz,1]);
% Anzahl Layer
layer=10;
for l=1:layer
    %Verschiebung x-Richtung nächste Schicht
    xnext(l,:)=4*r*rand([layer,1])-4*r/2;
end

for k=1:anz
    x=0; y=0;
    pdeellip(xstart(k),r,r,r)
    for i=1:layer 
        x=x+xnext(k,i);
        %Berechne Verschiebung y-Richtung, sodass Abstand 2r ist
        y=y+dy(xnext(k,i),r);
        pdeellip(xstart(k)+x,r+y,r,r)
    end 
end

set(findobj(get(pde_fig,'Children'),'Tag','PDEEval'),'String')

% PDE coefficients:
pdeseteq(1,...
'1.0',...
'0.0',...
'10',...
'1.0',...
'0:10',...
'0.0',...
'0.0',...
'[0 100]')
setappdata(pde_fig,'currparam',...
['1.0';...
'0.0';...
'10 ';...
'1.0'])

% Solve parameters:
setappdata(pde_fig,'solveparam',...
char('0','1000','10','pdeadworst',...
'0.5','longest','0','1E-4','','fixed','Inf'))

% Plotflags and user data strings:
setappdata(pde_fig,'plotflags',[1 1 1 1 1 1 1 1 0 0 0 1 1 0 0 0 0 1]);
setappdata(pde_fig,'colstring','');
setappdata(pde_fig,'arrowstring','');
setappdata(pde_fig,'deformstring','');
setappdata(pde_fig,'heightstring','');
