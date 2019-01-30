package com.xzit.ar.common.vo.info;

import java.io.Serializable;

/**
 * @author litianyi
 */
public class ResponseResult<T> implements Serializable{

    /**
     * 错误码
     */
    private int code;

    private long total;

    public static void loadResponce() {

    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    /**
     * 错误信息
     */
    private String message;
    /**
     * 业务数据
     */
    private T data;

    public ResponseResult(T data, long total) {
        this.data = data;
        this.total=total;
    }

    public ResponseResult(int code, String message, T data, int total) {
        this.code = code;
        this.message = message;
        this.data = data;
        this.total=total;
    }


    public static <T> ResponseResult build(T data,long total){
        return new ResponseResult(data,total);
    }

    /**
     * 是否成功
     *
     * @return
     */
    public boolean isSuccess() {
        return 0 == code;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }


}
