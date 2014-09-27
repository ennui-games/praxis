function WidgetLib.newCamAligned()
  local w = WidgetLib.newSimple()
  w.update = function(w)
    transform.copy(w.lspace, transform.camera())
    transform.applyTranslation(w.lspace, 0,0,10)
  end
  w.render = function(w)
    beginQuadGL()
      colorGL(255,155,0,255)
      vectorGL(0, 0,0)
      vectorGL(10,0,0)
      vectorGL(10,5,0)
      vectorGL( 0,5,0)
    endGL()
  end
  return w
end

Widgets = {}
clearError()
continue()

graphWidget = WidgetLib.newCamAligned()


transform.applyTranslation(graphWidget.lspace, 0,10,0)

                          
graphWidget.update = function (w) end


print2(getFunction("graphWidget.update"))

print2(graphWidget.depth)
print2(graphWidget.height)
print2(graphWidget.width)

clearError()
continue()

do
  graphWidget.depth = 10
  graphWidget.height = 5
  graphWidget.width = 10
  graphWidget.xMax = 100
  graphWidget.xMin = -10
  graphWidget.yMax = 100
  graphWidget.yMin = -20
  graphWidget.xRange = graphWidget.xMax - graphWidget.xMin
  graphWidget.yRange = graphWidget.yMax - graphWidget.yMin
  graphWidget.xScale = graphWidget.width / graphWidget.xRange
  graphWidget.yScale = graphWidget.height / graphWidget.yRange
  graphWidget.xOff = 1
  graphWidget.yOff = 1
  graphWidget.update = function(w)
    transform.copy(w.lspace, transform.camera())
    do
    local p1 = vec3d(transform.getTranslation(w.lspace))
    local p2 = vec3d(transform.localToGlobal(
                           w.lspace,
                           w.xOff,w.yOff,w.depth))
    local p = p2 - p1
    transform.applyTranslation(w.lspace, p.x, p.y, p.z)
    end
  end
  graphWidget.render = function(w)
    glPushMatrix()
    glScale(w.xScale,w.yScale,1)
    glTranslate(-w.xMin, -w.yMin,0)
    beginQuadGL()
      colorGL(255,155,0,255)
      vectorGL(w.xMin, w.yMin, 0)
      vectorGL(w.xMax, w.yMin, 0)
      vectorGL(w.xMax, w.yMax, 0)
      vectorGL(w.xMin, w.yMax, 0)
    endGL()
    glPopMatrix()
    
    colorGL(255,255,255,255)
    glPushMatrix()
    glScale(0.05,0.1,1)
    glRotate(-90,1,0,0)
    glTranslate(0,0,-5)
    drawText3DStroked(string.format("%.1f,%.1f",
                                    w.mousepos.x,
                                    w.mousepos.y),
                      0,0,0)
    glPopMatrix()
  end
  graphWidget.mousepos = vec3d(0,0,0)
  graphWidget.l2 = transform.new()
  graphWidget.mousemove = function (w,x,y,z)
    transform.copy(w.l2, transform.camera())
    do
    local p1 = vec3d(transform.getTranslation(w.l2))
    local p2 = vec3d(transform.localToGlobal(
                           w.l2,
                           w.xOff,w.yOff,w.depth))
    local p = p2 - p1
    transform.applyTranslation(w.l2, p.x, p.y, p.z)
    end
    --transform.applyTranslation(w.l2, w.xOff, w.yOff, 0)
    transform.applyScale(w.l2, w.xScale,w.yScale,1)
    local p1 = vec3d(transform.getTranslation(w.l2))
    local p2 = vec3d(transform.localToGlobal(w.l2, -w.xMin, -w.yMin, w.depth))
    local p = p2 - p1
    transform.applyTranslation(w.l2, p.x, p.y, p.z)
    w.mousepos:set(transform.globalToLocal(w.l2, getMouseCursorPos()))
  end
  graphWidget.lmbdown = function (w,x,y,z)
    --transform.copy(transform.cameraBase(), w.lspace)
  end
  graphWidget.rangecheck = function (w)
    local x,y,z = getMouseCursorPos()
    local lx,ly,lz = transform.globalToLocal(w.lspace, x,y,z)
    if lx > w.xMin and lx < w.xMax and
       ly > w.yMin and ly < w.yMax and
       lz > -1     and lz < 1 then
      return true
    else
      return false
    end
  end
  --graphWidget.rangecheck = nil
end

graphWidget.height = 5
transform.copy(transform.cameraBase(), transform.new())
clearError()











clearError()
continue()








print2(getFPS())








