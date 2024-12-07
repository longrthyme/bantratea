/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import entity.CartDetails;
import entity.Coupon;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Huyen Tranq
 */
public class CalculateDiscount {
      private List<String> errorMessages = new ArrayList<>();

    public double processDiscount(Coupon couponDetails, String couponCode, List<CartDetails> cartInfo) {
        double initialCartAmount = calculateTotalCartAmount(cartInfo);
        validateCoupon(couponDetails, couponCode, cartInfo);
        if (couponCode == null || couponCode.isEmpty()) {
            return initialCartAmount;
        }
        if (!errorMessages.isEmpty()) {
            return initialCartAmount;
        }
        return CalculateDiscountBasedOnDiscountType(couponDetails.getDiscountType(), cartInfo);
    }

    public double calculateTotalCartAmount(List<CartDetails> cartInfo) {
        double totalCartAmount = 0;
        if (cartInfo != null) {
            for (CartDetails item : cartInfo) {
                int price = item.product.getPrice();
                int quantity = item.getQuantity();
                totalCartAmount += price * quantity;
            }
        }
        return totalCartAmount;
    }

    public void validateCoupon(Coupon couponDetails, String couponCode, List<CartDetails> cartInfo) {
        if (couponCode == null || couponCode.isEmpty()) {
            errorMessages.add("Vui lòng nhập mã coupon");
        } else if (couponDetails == null) {
            errorMessages.add("Coupon không tồn tại");
        } else if ("inactive".equals(couponDetails.getCouponStatus())) {
            errorMessages.add("Coupon không sử dụng được");
        } else {
            Date today = new Date();
            Date validUntil = couponDetails.getValidUltil();
            if (validUntil.before(today)) {
                errorMessages.add("Coupon đã hết hạn");
            } else if (couponDetails.getTimeUsed() == 1) {
                errorMessages.add("Coupon đã được sử dụng");
            }
        }
    }

    public List<String> getErrorMessages() {
        return errorMessages;
    }

    public double CalculateDiscountBasedOnDiscountType(int discountType, List<CartDetails> cartInfo) {
        double totalCartAmount = 0;
        if (cartInfo == null || cartInfo.isEmpty()) {
            errorMessages.add("Giỏ hàng rỗng");
            return totalCartAmount;
        }
        switch (discountType) {
            case 1: { // Mua 1 tặng 1
                double minPrice = Double.MAX_VALUE;
                int minPriceCount = 0;
                int totalQuantity = 0;
                for (CartDetails item : cartInfo) {
                    int price = item.product.getPrice();
                    int quantity = item.getQuantity();
                    double itemTotal = price * quantity;
                    totalCartAmount += itemTotal;
                    totalQuantity += quantity;

                    if (price < minPrice) {
                        minPrice = price;
                        minPriceCount = quantity;
                    } else if (price == minPrice) {
                        minPriceCount += quantity;
                    }

                }
                if (cartInfo.size() <= 1 && totalQuantity <= 1) {
                    errorMessages.add("Giỏ hàng phải có nhiều hơn 1 sản phẩm để áp dụng mua 1 tặng 1.");
                    return totalCartAmount;
                } else {
                    int freeItems = totalQuantity / 2;
                    double freeAmount = Math.min(freeItems, minPriceCount) * minPrice;
                    totalCartAmount -= freeAmount;

                    if (totalCartAmount < 0) {
                        totalCartAmount = 0;
                    }
                }

            }
            break;

            // mua 2 tặng 1
            case 2: {
                double minPrice = Double.MAX_VALUE;
                int minPriceCount = 0;
                int totalQuantity = 0;

                for (CartDetails item : cartInfo) {
                    int price = item.product.getPrice();
                    int quantity = item.getQuantity();
                    double itemTotal = price * quantity;
                    totalCartAmount += itemTotal;
                    totalQuantity += quantity;

                    if (price < minPrice) {
                        minPrice = price;
                        minPriceCount = quantity;
                    } else if (price == minPrice) {
                        minPriceCount += quantity;
                    }
                }
                if (cartInfo.size() <= 2 && totalQuantity <= 2) {
                    errorMessages.add("Giỏ hàng phải có nhiều hơn 2 sản phẩm để áp dụng mua 2 tặng 1.");
                    return totalCartAmount;
                } else {
                    int totalFreeItems = (int) Math.ceil(totalQuantity / 3.0);
                    double freeAmount = Math.min(totalFreeItems, minPriceCount) * minPrice;
                    totalCartAmount -= freeAmount;

                    if (totalCartAmount < 0) {
                        totalCartAmount = 0;
                    }
                }

            }
            break;

            // giảm 25% hóa đơn
            case 3: {
                for (CartDetails item : cartInfo) {
                    int price = item.product.getPrice();
                    int quantity = item.getQuantity();
                    totalCartAmount += price * quantity;
                }
                totalCartAmount *= 0.75;
            }
            break;
            // giảm 15% hóa đơn
            case 4: {
                for (CartDetails item : cartInfo) {
                    int price = item.product.getPrice();
                    int quantity = item.getQuantity();
                    totalCartAmount += price * quantity;
                }
                totalCartAmount *= 0.85;

            }
            break;
            // giảm 30% hóa đơn
            case 5: {
                for (CartDetails item : cartInfo) {
                    int price = item.product.getPrice();
                    int quantity = item.getQuantity();
                    totalCartAmount += price * quantity;
                }
                totalCartAmount *= 0.70;

            }
            break;

        }
        return totalCartAmount;
    }
}

