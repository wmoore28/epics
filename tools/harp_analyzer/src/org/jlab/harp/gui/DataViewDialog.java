/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.jlab.harp.gui;

import java.awt.Dimension;
import javax.swing.JDialog;
import org.jlab.data.graph.DataSetXY;
import org.jlab.data.graph.DataTable;
import org.jlab.scichart.canvas.ScChartCanvas;

/**
 *
 * @author gavalian
 */
public class DataViewDialog extends JDialog {
    private ScChartCanvas chartCanvas = null;
    public DataViewDialog(DataTable tbl , int c , String[] names){
        super();
        this.setSize(800, 800);
        this.setPreferredSize(new Dimension(800,800));
        chartCanvas = new ScChartCanvas(800,800,1,names.length);
        chartCanvas.setMargins(0.01, 0.01, 0.01, 0.01);
        for(int loop = 0; loop < names.length; loop++){
            DataSetXY  data = tbl.getDataSet(0, c+loop);
            chartCanvas.addLine(loop, data.getDataX().getArray(),
                    data.getDataY().getArray(),4);
            String[] legend = new String[1];
            legend[0] = names[loop];
            chartCanvas.addLegend(loop, 0.01, 0.01, legend);
        }
        
        this.add(chartCanvas);
        this.addComponentListener(chartCanvas);
    }
}
