/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.jlab.harp.gui;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.TextField;
import java.util.ArrayList;
import javax.swing.BoxLayout;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingConstants;
import javax.swing.border.TitledBorder;

/**
 *
 * @author gavalian
 */
public class ParameterPanel extends JPanel {
    private TitledBorder titled = null;
    private ArrayList<JTextField>  minValues = new ArrayList<JTextField>();
    private ArrayList<JTextField>  maxValues = new ArrayList<JTextField>();
    private JComboBox              wireToFit = new JComboBox();
    public ParameterPanel(String paneltitle, 
            String[] labels){
        
        super();
        int count = labels.length;
        titled = new TitledBorder(paneltitle);
        this.setPreferredSize(new Dimension(500,count*55));
        this.setMaximumSize(new Dimension(400,count*55));
        this.setBorder(titled);
        this.setLayout(new GridLayout(count,2,10,10));
        
        for(int loop = 0; loop < count; loop++){
            JLabel label = new JLabel(labels[loop]);
            label.setHorizontalAlignment(SwingConstants.RIGHT);
            this.add(label);
            JPanel insidePanel = new JPanel();
            insidePanel.setLayout(new FlowLayout());
            JTextField minText = new JTextField(4);
            JTextField maxText = new JTextField(4);  
            minText.setHorizontalAlignment(JTextField.RIGHT);
            maxText.setHorizontalAlignment(JTextField.RIGHT);
            insidePanel.add(minText);
            insidePanel.add(maxText);
            minValues.add(minText);
            maxValues.add(maxText);
            this.add(insidePanel);            
        }
        
        for(int loop = 0; loop < count; loop++){
            this.setMinMax(loop, 0.0, 0.0);
        }
        /*
        JLabel label = new JLabel(" Wire to Fit : ");
        wireToFit = new JComboBox(new String[]{"2","3","4","5","6","7","8"});
        this.add(label);
        this.add(wireToFit);*/
    }
    
    
    public void setEditable(boolean isEditable){
        for(JTextField field : minValues){
            field.setEditable(isEditable);
        }
        for(JTextField field : maxValues){
            field.setEditable(isEditable);
        }
    }
    
    public void setMinMax(int index, Double min, Double max){
        minValues.get(index).setText(min.toString());
        maxValues.get(index).setText(max.toString());
    }
    
    public double getMin(int index){
        return Double.parseDouble(minValues.get(index).getText());
    }
    
    public double getMax(int index){
        return Double.parseDouble(maxValues.get(index).getText());
    }
    
    public int getWireToFit(){
        String item =(String) wireToFit.getSelectedItem();
        return Integer.parseInt(item);
    }
    
    public static void main(String[] args){
        JFrame frame = new JFrame();
        frame.setLayout(new BorderLayout());
        ParameterPanel panel = new ParameterPanel("Wire Positions",
                new String[]{"Wire 1 pos (min/max)","Wire 2 pos (min/max)",
                "Wire 3 pos (min/max)"});
        ParameterPanel panel2 = new ParameterPanel("Fit Peak Position",
                        new String[]{"Wire 1 pos (min/max)","Wire 2 pos (min/max)"}
                                );
        ParameterPanel panel3 = new ParameterPanel("Amplitudes",
                        new String[]{"Wire 1 pos (min/max)"}
        );
        frame.setLayout(new BoxLayout(frame.getContentPane(), BoxLayout.PAGE_AXIS));
        frame.add(panel);
        frame.add(panel3);
        frame.add(panel2);
        frame.pack();
        frame.setSize(600,300);
        //for(int loop = 0 ; loop < 3 ; loop++)
        frame.pack();
        frame.setVisible(true);
        System.err.println("Wire To Fit = " + panel.getWireToFit());
    }   
}
