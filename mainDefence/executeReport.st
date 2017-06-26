function executeReport() {

    console.debug("executeReport");

    var tree = <tree:tree()>;
    var panel = <panel:panel()>;
    var log, split;
     <if(log)>
        split = <split:split()>;
        log = <log:htmlPanel()>;
    <endif>

    var selectedReport = tree.selectedObject();
    if (!selectedReport || !selectedReport.reportId) return;

    if (selectedReport.format == "d3_diagram") {
        showWaiting('Построение диаграммы...');
        $.Retools.promise(
			$.Retools.openDocuments (
				'<d3ClassModel>',
				null,
				{
					reportId: selectedReport.reportId
				}
			);
		)
		.then(hideWaiting)
        .catch($.Retools.hideWaitingAndShowError);
    } else {
        $.Globals().loadControllerByName('ReportExecutor');
        $.ReportExecutor().run(panel, log, split, selectedReport, <formCode()>);
    }
}