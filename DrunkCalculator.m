function drunk
set(0,'DefaultFigureWindowStyle','normal')

monsize = get(0,'ScreenSize');

% set up the figure. Note that position corresponds to [left,bottom, width,height].
calcfig = figure('Position',[123 200 monsize(3)*.35 monsize(4)*.50],'menubar','none','name','Yes, officer, I''m a calculator','Numbertitle','off');


% fix the size of the calculator and change the background color
set(calcfig,'resize','off','color','#5e0836')
figsize = get(calcfig,'Position');
figsize = figsize(3:4);
% locations of the button positions
xfracs = linspace(.07,.5,3);
yfracs = linspace(.6,.1,4);


% create buttons for digits 1-10
for bnum=1:10
    
    h(bnum) = uicontrol('style','pushbutton',...
        'string',num2str(mod(bnum,10)),...
        'FontSize',15,...
        'Callback',@but,...
        'BackgroundColor','#f2cbe0',...
        'Position',[xfracs(mod(bnum-1,3)+1)*figsize(1) yfracs(ceil(4*bnum/12))*figsize(2) 80 40]);
end

% buttons +-/*
symbs = '+-/*';
for si=1:length(symbs)
    
    uicontrol('style','pushbutton',...
        'string',symbs(si),...
        'FontSize',15,...
        'Callback',@but,...
        'BackgroundColor','#fc97cd',...
        'Position',[.8*figsize(1) yfracs(si)*figsize(2) 80 40]);
end

% equals sign
uicontrol('style','pushbutton',...
    'string','=',...
    'FontSize',15,...
    'Callback',@but,...
    'Position',[.3*figsize(1) .1*figsize(2) 176 40]);

% clear button
uicontrol('style','pushbutton',...
    'string','clear',...
    'FontSize',15,...
    'Callback',@but,...
    'Position',[.675*figsize(1) .1*figsize(2) 57 40]);

% display bar
txth = uicontrol('style','text',...
    'string','',...
    'FontSize',17,...
    'Callback',@but,...
    'backgroundcolor','#f5ebf0',...
    'HorizontalAlignment','right',...
    'Position',[.07*figsize(1) .78*figsize(2) .87*figsize(1) 55]);

function but(source,eventdata)
    
    % flash the color of the calling button
    set(source,'BackgroundColor',[.3 .4 .8])
    pause(.1)
   

    set(source,'BackgroundColor',[.1 .5 .3]);


% update the display so that the pressed button shows up
    whichbutton = get(source,'string');
    displaytext = get(txth,'String');

  
      if isequal(whichbutton,'=')
        
        try
            result = num2str(eval( displaytext ));
            set(txth,'String',[ '= ' result ])
        catch me;
            set(txth,'string',[ '= ' getaphrase]);
        end
         % if the user clears the screen
    elseif isequal(whichbutton,'clear')
        set(txth,'string','')
        
    % not equals sign; update display    
    else
        
        % clean the display if '=' is the first character
        if isempty(displaytext) || isequal(displaytext(1),'=')
            set(txth,'string',whichbutton);
        else
            set(txth,'string',[displaytext whichbutton]);
        end
      end


       % randomly change a button label
    if rand>.9
        changebutton;
        pause(.40);
     set(calcfig,'color','#34eb61');
                 set(txth,'string',"I am going to throw up");
                 pause(10)
                      set(calcfig,'color','#c71429');
                                       set(txth,'string',"You are cute");
                                           pause(10)
                                            set(calcfig,'color','#610c4d');
                                                   pause(100)
                                              



               
                  


    end

    
    
    
end

function msg = getaphrase
    allmsg = {...
        'oh, I''ve had one too many.',...
        'no, you shut up!',...
        'I''m not drunk, you''re a... wait, what?',...
        'I love you, man.',...
        'Last call? But I just got here!',...
        'Calculator? But I hardly know her!',...
        'Don''t worry about me, I''ll get home.',...
        'Tequilla for me? Tequilla for everyone!'
        };
    msg = allmsg{randi(length(allmsg))};
end


function changebutton
    set(h(randi(10)),'string',num2str(randi(10)-1));
end

end





