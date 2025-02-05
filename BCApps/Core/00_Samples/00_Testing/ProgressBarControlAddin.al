controladdin "ProgressBarControlAddIn"
{
    Scripts = 'progressbar.js';
    StartupScript = 'progressbar.js';
    StyleSheets = 'progressbar.css';

    RequestedHeight = 30;
    RequestedWidth = 400;

    procedure UpdateProgress(Percentage: Integer);
}
