

begin

  ir = 0 
  ss = "ANN" 

  vn = (/"AODVIS", "AODSO4", "AODBC", "AODPOM", "AODSOA", "AODDUST", "AODSS", "AODABS"/)
  
  str_region_name = (/"Global", \
                      "Land",   \
                      "Ocean",  \
                      "60N-90N", \
                      "30N-60N", \
                      "20N-20N", \
                      "30S-60S", \
                      "60S-90S", \
                      "NH", \ 
                      "SH"  /)

  plotform = "pdf" 
  plotname = "figure_xy_aod_v3_3member_hist_" + ss + "_" + str_region_name(ir)

;;.............................................................
;; input 
;;.............................................................

  fna = "data/ts_glb_v3.LR.historical_0051_" + ss + ".nc"
  fnb = "data/ts_glb_v3.LR.historical_0101_" + ss + ".nc"
  fnc = "data/ts_glb_v3.LR.historical_0151_" + ss + ".nc"

  print("input : " + fna ) 
  print("input : " + fnb ) 
  print("input : " + fnc ) 

  fla = addfile(fna,"r") 
  flb = addfile(fnb,"r")
  flc = addfile(fnc,"r")

  myfont = 0.02 
  FontHeight = myfont
  ThicknessF = 0.25

  nvar = dimsizes(vn) 

  vtmp = fla->AODVIS

  nt   = 165 ;; dimsizes(vtmp(:,0)) 
  nreg = dimsizes(vtmp(0,:)) 

  va = new((/nvar,nt,nreg/),"float") 
  vb = new((/nvar,nt,nreg/),"float")
  vc = new((/nvar,nt,nreg/),"float") 

  year = ispan(1,nt,1) 

  year = year + 1850 - 1

  year@units = "year" 

;;.............................................................
;; read data 
;;.............................................................

  do iv = 0,nvar-1 

     print("varname : " + vn(iv) ) 

     va(iv,:,:)   = fla->$vn(iv)$ 
     vb(iv,:,:)   = flb->$vn(iv)$  
     vc(iv,:,:)   = flc->$vn(iv)$  

  end do
  
  np = 8

  myplot  = new(np,graphic)

  vx1 = year
  vy1 = new((/3,nvar,nt,nreg/),"float")
  
  vy1(0,:,:,:) = va(:,:,:)
  vy1(1,:,:,:) = vb(:,:,:)
  vy1(2,:,:,:) = vc(:,:,:)
  
  vy1&time@long_name = "time"
  vy1@long_name = "time"
  delete(vy1@units)
  
  
;;.............................................................
;; tr
;;.............................................................
  trXMinF     = 1850 ;;0 
  trXMaxF     = 2014 ;;300

;;.............................................................
;; xy
;;.............................................................
  xyLineColors      = (/"darkorchid1","darkseagreen","grey50","orange","green","brown","purple"/)
  xyLineThicknesses = (/2.,2.,2.,1.,1.,1.,1./)  
  xyDashPatterns    = (/0,0,0,0,2,2,2/)

;;.............................................................
;; legend
;;.............................................................
  pmLegendParallelPosF   = .70                 ; move units right
  pmLegendOrthogonalPosF = -0.4                ; move units down
  pmLegendWidthF         = 0.18                ; Change width and
  pmLegendHeightF        = 0.07                ; height of legend.
  lgLabelFontHeightF     = 0.018               ; change font height
  lgBoxMinorExtentF      = 0.15       ; Shorten the legend lines
  xyExplicitLegendLabels = " " + (/"v3_hist_0051","v3_hist_0101","v3_hist_0151"/)         ; explicit labels

;;.............................................................
;; marker
;;.............................................................
  xyMarkers           = (/16,16,16,16,16,16,16/)
  xyMarkerColors      = xyLineColors
  xyMarkerSizes       = (/0.01,0.01,0.01,0.01,0.01,0.01,0.01/)
  xyMarkerThicknesses = (/2.,2.,2.,2.,2.,2.,2./)

  Lines               = (/"Lines","Lines","Lines","Lines","Lines","Lines","Lines"/)
  Markers             = (/"Markers","Markers","Markers","Markers","Markers","Markers","Markers"/)
  xyMarkLineModes     = Lines

;;.............................................................
;; xy titles
;;.............................................................
  tiYAxisString = "Normalized ~F33~D~F~Burden "
  tiYAxisString = "~F33~D~F~Burden (kg m~S~-2~N~)"
  tiYAxisString = "Burden (kg m~S~-2~N~)"
  tiYAxisString = "Optical Depth (unitless)"


;;.............................................................
;; wrks
;;.............................................................
  wks   = gsn_open_wks (plotform,plotname)              ; open workstation
  gsn_define_colormap(wks,"ncl_default")   ;"amwg256"

  res                       = True
  res@gsnFrame              = False
  res@gsnDraw               = False

;;.............................................................
;; title
;;.............................................................
  res@tiMainFontHeightF     = myfont
  res@tiMainFontThicknessF  = 2
  res@tiMainOffsetYF        = -0.01

  res@tiXAxisOn      = True
  res@tiYAxisOn      = True

  res@tiXAxisFontHeightF    = myfont                ; XAxis Font
  res@tiYAxisFontHeightF    = myfont                ; YAxis Font

;;.............................................................
;; viewport
;;.............................................................
;;  res@vpXF                  = 0.10                 ; x location left
;;  res@vpYF                  = 0.90                 ; y location  up
  res@vpWidthF              = 0.60                 ; width
  res@vpHeightF             = 0.30                 ; height

;;.............................................................
;; string
;;.............................................................
  res@gsnLeftStringFontHeightF    = myfont
  res@gsnRightStringFontHeightF   = myfont
;;res@gsnLeftStringOrthogonalPosF = 0.02
;;res@gsnRightStringOrthogonalPosF= 0.02
;;res@gsnStringFontHeightF        = 0.02

;;.............................................................
;; tm
;;.............................................................
  res@tmXTOn      =False
  res@tmYROn      =False
  res@tmXBLabelFontHeightF  = myfont * 0.8
  res@tmYLLabelFontHeightF  = myfont * 0.8
;;res@tmXBLabelFontAspectF  = 1.0
;;res@tmYLLabelFontAspectF  = 1.0

  res@tmYLFormat = "0*+^E"

;;.............................................................
;; tr
;;.............................................................
;;res@trYMinF     = 0. 
;;res@trYMaxF     = trYMaxF
  res@trXMinF     = trXMinF
  res@trXMaxF     = trXMaxF

;;.............................................................
;; xy
;;.............................................................
  res@xyLineColors      = xyLineColors
  res@xyLineThicknesses = xyLineThicknesses
  res@xyDashPatterns    = xyDashPatterns

  res@gsnYRefLine           = 0.0             ; create a reference line   
  res@gsnYRefLineColor      = "grey"
  res@gsnYRefLineDashPattern = 2
  res@gsnYRefLineThicknessF  = 1 
 
;;.............................................................
;; text
;;.............................................................
  res_text                    = True                  ; text mods desired
  res_text@txFontHeightF      = myfont * 0.5 
  res_text@txFontThicknessF   = 1.                   ; thickness of the lines
  res_text@txJust             = "CenterCenter"          ; text justification
   
;;.............................................................
;; add text
;;.............................................................
  txres                         = True
  txres@txFont                  = "helvetica-bold"
  txres@txFont                  = "helvetica"
  txres@txFontHeightF           = myfont * 0.6
  txres@txFontThicknessF        = 1.0



;;.............................................................
;; legend
;;.............................................................
  res@pmLegendDisplayMode    = "Always"               ; turn on legend
  res@pmLegendSide           = "Top"                  ; Change location of 
  res@pmLegendParallelPosF   = pmLegendParallelPosF   ; move units right
  res@pmLegendOrthogonalPosF = pmLegendOrthogonalPosF ; move units down
  res@pmLegendWidthF         = pmLegendWidthF         ; Change width and
  res@pmLegendHeightF        = pmLegendHeightF        ; height of legend.
  res@xyExplicitLegendLabels = xyExplicitLegendLabels  ; explicit labels

  res@lgPerimOn              = False                ; turn off box
  res@lgLabelFontHeightF     = lgLabelFontHeightF   ; change font height
  res@lgBoxMinorExtentF      = lgBoxMinorExtentF    ; Shorten the legend lines
  res@lgTitleOn              = False                ; turn on legend title
  res@lgTitleString          = "Example"            ; create legend title
  res@lgTitleFontHeightF     = .02                  ; font of legend title

;;.............................................................
;; marker
;;.............................................................
  res@xyMarkLineModes     = xyMarkLineModes
  res@xyMarkers           = xyMarkers
  res@xyMarkerColors      = xyLineColors
  res@xyMarkerSizes       = xyMarkerSizes
  res@xyMarkerThicknesses = xyMarkerThicknesses

  res@tfPolyDrawOrder    = "Predraw"               ; put line on top 
  
  res@xyMarkLineModes =  Lines

  res@tiYAxisString = tiYAxisString
  res@tiXAxisString = "Year"
  res@tiXAxisString = " " 
     
;;.............................................................
;; loop over plotting variables 
;;.............................................................

  panel_index = (/"(a)", "(b)", "(c)", "(d)", "(e)", "(f)","(g)", "(h)"/)
  
  do ip = 0, np-1 
     res@trYMinF       = 0.8 * min(vy1(:,ip,:,ir))
     res@trYMaxF       = 1.2 * max(vy1(:,ip,:,ir)) 
     res@gsnLeftString  = panel_index(ip) + " " + vn(ip)
     myplot(ip) = gsn_csm_xy(wks,vx1,vy1(:,ip,:,ir),res)
  end do 


  region_name = (/"Global", \
                  "Land",   \
                  "Ocean",  \
                  "NH Polar (60~F34~0~F~N-90~F34~0~F~N)",   \
                  "NH Mid-lat (30~F34~0~F~N-60~F34~0~F~N)", \
                  "Tropics (20~F34~0~F~S-20~F34~0~F~N)",    \
                  "SH Mid-lat (30~F34~0~F~S-60~F34~0~F~S)", \
                  "SH Polar (60~F34~0~F~S-90~F34~0~F~S)", \
                  "NH", \
                  "SH"  /)
                  
;;.............................................................
;; panel
;;.............................................................
  resp = True
  resp@txString                   = ss + " " + region_name(ir) 
  resp@txFontHeightF              = 0.02
  resp@txFontThicknessF           = 0.25*5
  resp@gsnPanelYWhiteSpacePercent = 2
  resp@gsnPanelXWhiteSpacePercent = 2
  gsn_panel(wks,myplot,(/4,2/),resp)


end

