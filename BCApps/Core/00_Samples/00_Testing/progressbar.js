function UpdateProgress(percentage) {
    let bar = document.getElementById('progress-bar');
    if (bar) {
        bar.style.width = percentage + '%';
        bar.textContent = percentage + '%';
    }
}
