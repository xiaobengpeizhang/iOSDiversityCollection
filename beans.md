###　配比调节

``` java

    /** 配比常量 */
    private final static int amount = 100;//配比总额
    private final static int minValue = 10;//配比最小值
    
    
    /**
     * 按豆子数获取百分比数值
     *
     * @param num 豆子数
     * @return 百分比
     */
    private List<Integer> getValues(int num) {
        List<Integer> mList = new ArrayList<>();//初始化列表
        int mean = amount / num;
        int remainder = amount % num;
        for (int i = 0; i < num; i++) {
            if (i == (num - 1)) {
                mList.add(mean + remainder);//将取余值赋值给最后一个
            } else {
                mList.add(mean);
            }
        }
        return mList;
    }
    
    /**
         * 获取最大可调额度
         * @param sliceValues 百分比数据集
         * @param arcIndex 需要修改比例的豆子索引位置
         * @param locks 锁定的豆子集
         * @return 需要修改的豆子的最值
         */
        private Map<String, Integer> getMaxValue(List<Integer> sliceValues, int arcIndex, Set<Integer> locks) {
            Map<String, Integer> map = new HashMap<>();
            int min = minValue, max = minValue;
            int lockNum = 0, quantity = 0, unLockNum = 0, adjustEnable = 0;
            for (int i = 0; i < sliceValues.size(); i++) {
                if (locks.contains(i)) {
                    if (i != arcIndex) {
                        lockNum = lockNum + sliceValues.get(i);
                    }
                } else {
                    if (i == arcIndex) {
                        quantity = 1;
                    }
                }
            }
            quantity = sliceValues.size() - locks.size() - quantity;
            unLockNum = quantity * minValue;
            max = amount - lockNum - unLockNum;
            map.put("min", min);
            map.put("max", max);
            return map;
        }
    
        /**
         * 按百分百修改图表数据
         *
         * @param sliceValues 百分比数据集
         * @param arcIndex    需要修改的豆子索引位置
         * @param value       修改后的值
         * @param locks       豆子锁定集
         * @return 改变的数据集
         */
        private List<Integer> setSliceValues(List<Integer> sliceValues, int arcIndex, int value, Set<Integer> locks) {
            /**
             * 锁定总值、未锁定个数、未锁定最小总值
             * 能调整最大值、调节完差值、差值平均值、差值余数、最后记录位置
             */
            int  lockNum = 0, quantity = 0, unLockNum = 0, adjustEnable = 0,
                    difference = 0, index = -1, mean = 0, remainder = 0;
            for (int i = 0; i < sliceValues.size(); i++) {
                if (locks.contains(i)) {
                    if (i != arcIndex) {
                        lockNum = lockNum + sliceValues.get(i);
                    }
                } else {
                    if (i == arcIndex) {
                        quantity = 1;
                    }
                }
            }
            quantity = sliceValues.size() - locks.size() - quantity;
            unLockNum = quantity * minValue;
            adjustEnable = amount - lockNum - unLockNum;
            value = value < minValue ? minValue : value;
            value = value > adjustEnable ? adjustEnable : value;
            difference = adjustEnable - value;
            if (difference != 0) {
                mean = difference / quantity;
                remainder = difference % quantity;
            }
            for (int i = 0; i < sliceValues.size(); i++) {
                if (locks.contains(i)) {
                    if (i == arcIndex) {
                        sliceValues.set(i, value);
                    }
                } else {
                    if (i == arcIndex) {
                        sliceValues.set(i, value);
                    } else {
                        sliceValues.set(i, minValue + mean);
                        index = i;
                    }
                }
            }
            if (index > 0 && remainder > 0) {
                sliceValues.set(index, sliceValues.get(index) + remainder);
            }
            return sliceValues;
        }

    
```
###  曲线调节

``` java

   /**
     * 图表调节常量
     */
    private final static int scale = 40;//风量图表比例尺
    private final static int plotting = 100;//风量调节比例尺
    private final static int tempMin = 90;//温度最小值
    private final static int tempMax = 230;//温度最大值
    private final static int cfmMin = 30;//风量最小值
    private final static int cfmMax = 100;//风量最大值
    private final static int maxTime = 1080;//总时长
    private final static int timeOneMin = 180;//第一点时间最小值
    private final static int timeOneMax = 420;//第一点时间最大值
    private final static int timeOtherMin = 90;//其他时间最小值
    private final static int timeOtherMax = 200;//其他时间最大值
    private final static int timeEndMin = 20;//最后一点时间最小值
    private final static int timeEndMax = 120;//最后一点时间最大值
    private boolean isChange = false;//能否调节
    /**
     * 线条位置
     */
    private int mlineIndex = -1;
    private final static int CURVE_TEMP = 0;
    private final static int CURVE_CFM = 1;
    /**
     * 点位
     */
    private int mPointIndex = -1;
    private final static int ZERO_POINT = 0;
    private final static int ONE_POINT = 1;
    private final static int FIVE_POINT = 5;
    
    
    private void initListener() {
        /**
         * 图表选择值
         */
        lineChart.setOnValueTouchListener(new LineChartOnValueSelectListener() {
            @Override
            public void onValueSelected(int lineIndex, int pointIndex, PointValue value) {
                mlineIndex = lineIndex;
                mPointIndex = pointIndex;
                //时间限制
                slider_time_reg.setEnabled(true);
                Map<String, Integer> time = getTimeExtreme(times, mPointIndex, durations);
                slider_time_reg.setValueRange(time.get("min"), time.get("max"), true);
                //判断是哪条线，设置不同的slider可调值
                slider_chart_reg.setEnabled(true);
                switch (mlineIndex) {
                    case CURVE_TEMP:
                        //温度不能超过230且不能低于上一个点位
                        tv_seekbar_type.setText(R.string.ym_curve_temp_change);
                        tv_seekbar_type.setTextColor(chart_line_temp);
                        slider_chart_reg.setPrimaryColor(chart_line_temp);
                        Map<String, Integer> temp = getExtreme(temps, mlineIndex, mPointIndex);
                        Log.d(TAG, "max:" + temp.get("max") + ",min:" + temp.get("min"));
                        if ((int) temp.get("min") >= temp.get("max")) {
                            slider_chart_reg.setValueRange(temp.get("min") - 1, temp.get("max") + 1, true);
                            isChange = false;
                        } else {
                            slider_chart_reg.setValueRange(temp.get("min"), temp.get("max"), true);
                            isChange = true;
                        }
                        break;
                    case CURVE_CFM:
                        tv_seekbar_type.setText(R.string.ym_curve_cfm_change);
                        tv_seekbar_type.setTextColor(chart_line_cfm);
                        slider_chart_reg.setPrimaryColor(chart_line_cfm);
                        Map<String, Integer> cfm = getExtreme(cfms, mlineIndex, mPointIndex);
                        if ((int) cfm.get("min") == cfm.get("max")) {
                            slider_chart_reg.setValueRange(cfm.get("min") - 1, cfm.get("max") + 1, true);
                            isChange = false;
                        } else {
                            slider_chart_reg.setValueRange(cfm.get("min"), cfm.get("max"), true);
                            isChange = true;
                        }
                        break;
                }
                //判断是第几组，如果是第零组，设置slider不可用，否则设置可用并设置刻度
                switch (mPointIndex) {
                    case ZERO_POINT:
                        slider_chart_reg.setEnabled(false);
                        slider_time_reg.setEnabled(false);
                        break;
                    default:
                        slider_chart_reg.setEnabled(true);
                        switch (mlineIndex) {
                            case CURVE_TEMP:
                                slider_chart_reg.setValue((int) value.getY(), true);
                                break;
                            case CURVE_CFM:
                                slider_chart_reg.setValue((((int) value.getY() * scale) / plotting), true);
                                break;
                        }
                        slider_time_reg.setValue(durations[mPointIndex], true);
                        if (!isChange) {
                            Util.toastShow(getActivity(), R.string.ym_curve_unable);
                            slider_chart_reg.setEnabled(false);
                        }
                        break;
                }
            }

            @Override
            public void onValueDeselected() {

            }
        });

        /**
         * 温度及风量调节
         * 最低温度90，最高温度230，后一个点必须高于前一个
         * 最少风量不低于30，后一个必须高于前一个
         */
        slider_chart_reg.setOnPositionChangeListener(new Slider.OnPositionChangeListener() {
            @Override
            public void onPositionChanged(Slider view, boolean fromUser, float oldPos, float newPos, int oldValue, int newValue) {
                if (!fromUser) return; //不是用户调节直接return
                if (mPointIndex != 0) {
                    switch (mlineIndex) {
                        case CURVE_TEMP://温度
                            temps[mPointIndex] = newValue;
                            break;
                        case CURVE_CFM://风量
                            cfms[mPointIndex] = newValue * plotting;
                            break;
                        default:
                            break;
                    }
                    //重新初始化图表
                    initChart();
                }
            }
        });

        /**
         * 温度及风量调节的展示值
         */
        slider_chart_reg.setValueDescriptionProvider(new Slider.ValueDescriptionProvider() {
            @Override
            public String getDescription(int value) {
                if (mlineIndex == CURVE_CFM) {
                    value = value * plotting;
                }
                return String.valueOf(value);
            }
        });

        /**
         * 时间调节
         * 第一个点，不能少于3分钟 最长不超过7分钟;总的时间不超过18分钟
         */
        slider_time_reg.setOnPositionChangeListener(new Slider.OnPositionChangeListener() {
            @Override
            public void onPositionChanged(Slider view, boolean fromUser, float oldPos, float newPos, int oldValue, int newValue) {
                //TODO 正因为这里对操作来源进行了处理，可能导致其他问题，可能
                if (!fromUser) return;//不是用户调节直接return
                if (mPointIndex != 0) {
                    durations[mPointIndex] = newValue;
                    for (int j = mPointIndex; j < times.length; j++) {
                        times[j] = times[j - 1] + durations[j];
                    }
                    initChart();
                }
            }
        });
    }

    /**
     * 温度及风量可调范围
     *
     * @param value      数据集
     * @param lineIndex  线条位置
     * @param pointIndex 点位
     * @return map{@code min:最小值,max:最大值}
     */
    private Map<String, Integer> getExtreme(int[] value, int lineIndex, int pointIndex) {
        Map<String, Integer> map = new HashMap<>();
        int min = 0, max = cfmMax;
        switch (lineIndex) {
            case CURVE_TEMP://温度
                switch (pointIndex) {
                    case ZERO_POINT:
                        break;
                    case ONE_POINT:
                        min = tempMin;
                        max = value[pointIndex + 1] - 1;
                        break;
                    default:
                        if (pointIndex < value.length - 1) {
                            min = value[pointIndex - 1] + 1;
                            if (pointIndex == 4) {
                                max = value[pointIndex + 1];
                            } else {
                                max = value[pointIndex + 1] - 1;
                            }
                        } else {
                            min = value[pointIndex - 1];
                            max = tempMax;
                        }
                        break;
                }
                break;
            case CURVE_CFM://风量
                switch (pointIndex) {
                    case ZERO_POINT:
                        break;
                    case ONE_POINT:
                        min = cfmMin;
                        max = (value[pointIndex + 1] / plotting) - 1;
                        break;
                    default:
                        if (pointIndex < value.length - 1) {
                            min = (value[pointIndex - 1] / plotting) + 1;
                            max = (value[pointIndex + 1] / plotting) - 1;
                        } else {
                            min = (value[pointIndex - 1] / plotting) + 1;
                            max = cfmMax;
                        }
                        break;
                }
                break;
        }
        map.put("min", min);
        map.put("max", max);
        return map;
    }

    /**
     * 时间可调范围
     *
     * @param value      数据集
     * @param pointIndex 位置
     * @return map{@code min:最小值,max:最大值}
     */
    private Map<String, Integer> getTimeExtreme(int[] value, int pointIndex, int[] duration) {
        int timeMax = maxTime - value[value.length - 1] + duration[pointIndex];
        Map<String, Integer> map = new HashMap<>();
        int min = timeOtherMin, max = timeOneMax;
        switch (pointIndex) {
            case ZERO_POINT:
                break;
            case ONE_POINT:
                min = timeOneMin;
                max = timeMax > timeOneMax ? timeOneMax : timeMax;
                break;
            case FIVE_POINT:
                min = timeEndMin;
                max = timeMax > timeEndMax ? timeEndMax : timeMax;
                break;
            default:
                min = timeOtherMin;
                max = timeMax;
                break;
        }
        map.put("min", min);
        map.put("max", max);
        return map;
    }
```