clc
clear
close all

x = 0:0.05:2*pi;

%% TELEMETRY SIGNALS
speed = 100 + 80*sin(x);
rpm   = 3000 + 1500*cos(x);
steer = sin(x);

vib = tan(x);
vib(abs(vib) > 5) = NaN;

xmin = min(x);
xmax = max(x);

%% FIGURE
figure
set(gcf,'Color','k')

sgtitle('F1 TELEMETRY LIVE DASHBOARD', ...
    'Color','c', ...
    'FontSize',18, ...
    'FontWeight','bold')

%% CREATE SPEED DISPLAY ONLY ONCE
hSpeed = annotation('textbox',[0.34 0.43 0.35 0.12], ...
    'String','0 km/h', ...
    'Color',[0 1 0], ...
    'FontSize',34, ...
    'FontWeight','bold', ...
    'EdgeColor','none', ...
    'HorizontalAlignment','center');

%% ANIMATION LOOP
for k = 1:3:length(x)

    currentSpeed = speed(k);

    %% UPDATE SPEED DISPLAY
    set(hSpeed,'String',sprintf('%03.0f km/h',currentSpeed));

    %% SPEED GRAPH
    subplot(2,2,1)

    plot(x(1:k),speed(1:k), ...
        'LineWidth',2.5, ...
        'Color',[0 1 0])

    title('Speed','Color','w')

    grid on

    axis([xmin xmax 0 200])

    set(gca, ...
        'Color','k', ...
        'XColor','w', ...
        'YColor','w', ...
        'GridColor',[0 1 0])

    %% RPM GRAPH
    subplot(2,2,2)

    plot(x(1:k),rpm(1:k), ...
        'LineWidth',2.5, ...
        'Color',[1 0.5 0])

    title('Engine RPM','Color','w')

    grid on

    axis([xmin xmax 1000 5000])

    set(gca, ...
        'Color','k', ...
        'XColor','w', ...
        'YColor','w', ...
        'GridColor',[1 0.5 0])

    %% STEERING GRAPH
    subplot(2,2,3)

    plot(x(1:k),steer(1:k), ...
        'LineWidth',2.5, ...
        'Color',[0.2 0.6 1])

    title('Steering Input','Color','w')

    grid on

    axis([xmin xmax -2 2])

    set(gca, ...
        'Color','k', ...
        'XColor','w', ...
        'YColor','w', ...
        'GridColor',[0.2 0.6 1])

    %% VIBRATION GRAPH
    subplot(2,2,4)

    plot(x(1:k),vib(1:k), ...
        'LineWidth',2.5, ...
        'Color',[1 0 0])

    title('Chassis Vibration','Color','w')

    grid on

    axis([xmin xmax -5 5])

    set(gca, ...
        'Color','k', ...
        'XColor','w', ...
        'YColor','w', ...
        'GridColor',[1 0 0])

    %% SPEED WARNING COLOR
    if currentSpeed > 160
        set(hSpeed,'Color',[1 0 0])   % RED
    else
        set(hSpeed,'Color',[0 1 0])   % GREEN
    end

    drawnow

end