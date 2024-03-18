/* 
 *  Export all the series in a CZI file to tiff files.
 *  
 *  Tao Tong (tongtao@gmail.com)
 *  of Bio-Imaging Resource Center in the Rockefeller University
 *  2024-03-12
 *
 */
run("Close All"); 
isBatch = true;
id = File.openDialog("Choose the CZI file");
setBatchMode(isBatch);
fileDir = File.getParent(id);
outputDir = File.getParent(id) + File.separator + "Output";
filename = File.getNameWithoutExtension(id);
if (!File.exists(outputDir)) {
	File.makeDirectory(outputDir);
}

run("Bio-Formats Macro Extensions");
Ext.setId(id);
Ext.getSeriesCount(seriesCount);

for (i = 1; i <= seriesCount; i++) {
	showProgress(i, seriesCount);
	run("Bio-Formats", "open=" + id + 
						" autoscale " + 
						"color_mode=Default " + 
						"rois_import=[ROI manager] " + 
						"view=Hyperstack " + 
						"stack_order=XYCZT " + 
						"series_" + i);	
	savePath = outputDir + File.separator + 
							filename + "_Series_" + i + ".tif";
	save(savePath);
	run("Close All");
	call("java.lang.System.gc");
}
setBatchMode("show");
showMessage("Conversion is finished!");