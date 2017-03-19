function plotDrone(x, y, z, length)
    DELTA = .1;
    LINE_WIDTH = 4;
    
    allz = zeros(1, numel(0 : DELTA : length));
    allz(:) = z;
    
    frontleftx = x - length : DELTA : x;
    frontlefty = y - length : DELTA : y;

    frontrightx = x : DELTA : x + length;
    frontrighty = y : DELTA : y + length;
    
    backleftx = x - length : DELTA : x;
    backlefty = y + length : -DELTA : y;
    
    backrightx = x : DELTA : x + length;
    backrighty = y : -DELTA : y - length;
    
    plot3(...
        frontleftx, frontlefty, allz, 'red',...
        frontrightx, frontrighty, allz, 'red',...
        backrightx, backrighty, allz, 'red',...
        backleftx, backlefty, allz, 'red',...
        'LineWidth', LINE_WIDTH ...
    )
end